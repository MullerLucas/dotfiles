---
name: pair-program
description: Breaks a task into small, individually reviewable steps so the user can check the git diff and commit (or amend) after each one before continuing.
disable-model-invocation: true
---

# Pair Program

This skill changes how you work through a session, not how you work through
a single task. The user drives the pace: they give you one task at a time,
you do it, they check the diff and commit.

## Workflow

1. **Get the task.** If the user invoked this skill with a task already
   described (as an argument or in the same message), use that. Otherwise
   ask what they want to work on.

2. **Stop when it's done.** Briefly say what you changed and why, then stop
   and hand control back. Do not run `git add`, `git commit`, or
   `git commit --amend` yourself — that's the user's call, every time.

3. **Wait for the user.** They will review `git diff` themselves and commit
   or amend on their own terms. Do not propose commit messages or ask
   "should I commit?" — assume they know how they want to commit and will
   tell you if they want help.

4. **Take the next task.** When the user comes back with the next task (or a
   correction to what you just did), work from the current state of the
   repo — re-check `git status`/`git log` rather than assuming your mental
   model still matches reality, since they may have amended or rebased.

5. **Repeat for as many tasks as the user gives.** There's no overall task
   list to track — each one is independent and given to you when the user
   is ready for it.

## Rules while this skill is active

- When reporting information to me, be extremely concise and sacrifice grammer for the sake of concision.
- Never commit, amend, or push on your own initiative.
- Don't split a given task into sub-steps that each stop for review — the
  user reviews once per task, when the task is complete.
- If the user's next message is a correction to what you just did rather
  than a new task, treat it as amending the current task, not as a
  separate one.
