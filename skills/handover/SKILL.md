---
name: handover
description: Write a handover note so a fresh session can pick up this work, or resume from one.
argument-hint: "[resume [file]] or [what to focus on]"
disable-model-invocation: true
---

## Write (default)

Save a note that lets a new session carry on without this conversation. Check facts against the repo (`git status`, branch, last commit, test results this session) rather than memory. Don't copy what commits, diffs or docs already hold: point to them.

Write it to `.claude/handovers/YYYY-MM-DD-<slug>.md` in the project root:

```
# <task in a few words>
Goal: <one line: what done looks like>
State: <branch> @ <short sha>; uncommitted: <files or none>; tests: <passing / failing: which / not run>
## Done
## Next
1. <first concrete action, with file or command>
## Decisions
- <choice> — <why> (only ones not recorded elsewhere)
## Tried and dropped
- <approach> — <why it failed>
## Open questions
- <what the user still has to decide>
## Gotchas
- <commands, setup, traps a newcomer would hit>
```

Leave out empty sections. Aim for under 50 lines. If `git check-ignore` says the folder isn't ignored, say so in one line. Never commit the note unless asked.

End with the path and the command to resume: `/handover resume`.

## Resume (`resume [file]`)

1. Read the given note, or the newest in `.claude/handovers/`. Say which.
2. Check it against the repo now: branch, commits since its sha, changed files, anything in **Next** already done. Report any drift in a line or two.
3. Summarise in three lines (goal, where it stands, next step), then ask whether to go on with the next step.
