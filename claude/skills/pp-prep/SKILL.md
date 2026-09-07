---
name: pp-prep
description: Optional preparation step of the Pair-Programming workflow
disable-model-invocation: true
argument-hint: "[desc]"
---

This is the first step of the pair programming (pp) workflow.
During this step, your goal is to gather all references, files, etc. that might help another agent to complete the task described by the user.
Write these information into `PREP.md` in the current working directory. 
If a `PREP.md` file already exists, update it.
Don't make any actual code changes during this step.
Keep the `PREP.md` file as concise as possible. Sacrifice grammar for the sake of concision.

$ARGUMENTS