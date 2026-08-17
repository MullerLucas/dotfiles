#!/usr/bin/env bash
# Claude Code status line: shows model, effort, and context window usage.

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "Claude"')
effort=$(echo "$input" | jq -r '.effort.level // empty')

total_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Colors (dim-friendly)
RESET="\033[0m"
DIM="\033[2m"
CYAN="\033[2;36m"
MAGENTA="\033[2;35m"
YELLOW="\033[2;33m"
RED="\033[2;31m"
GREEN="\033[2;32m"

ctx_str=""
if [ -n "$total_tokens" ] && [ -n "$ctx_size" ]; then
  # Human-readable token counts (e.g. 12.3k)
  human() {
    awk -v n="$1" 'BEGIN {
      if (n >= 1000) printf "%.1fk", n/1000;
      else printf "%d", n;
    }'
  }
  used_h=$(human "$total_tokens")
  size_h=$(human "$ctx_size")

  if [ -n "$used_pct" ]; then
    pct_int=$(awk -v p="$used_pct" 'BEGIN { printf "%d", p }')
  else
    pct_int=$(awk -v u="$total_tokens" -v s="$ctx_size" 'BEGIN { if (s>0) printf "%d", (u/s)*100; else print 0 }')
  fi

  if [ "$pct_int" -ge 80 ]; then
    color="$RED"
  elif [ "$pct_int" -ge 50 ]; then
    color="$YELLOW"
  else
    color="$GREEN"
  fi

  ctx_str=$(printf "${color}%s/%s (%s%%)${RESET}" "$used_h" "$size_h" "$pct_int")
fi

printf "${CYAN}%s${RESET}" "$model"
if [ -n "$effort" ]; then
  printf " ${DIM}|${RESET} ${MAGENTA}%s effort${RESET}" "$effort"
fi
if [ -n "$ctx_str" ]; then
  printf " ${DIM}|${RESET} Ctx: %b" "$ctx_str"
fi
printf "\n"
