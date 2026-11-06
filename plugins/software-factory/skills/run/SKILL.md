---
name: run
description: Run one pass of the software factory defined in factory/factory.yml - its sources create tickets, and every ticket moves one stage forward with persona subagents.
disable-model-invocation: true
---

Run **one pass** of the factory, then report. For a continuous factory the user repeats it with `/loop` or a schedule.

## Before the pass

1. Read `factory/factory.yml`, and `${CLAUDE_SKILL_DIR}/../../defaults.yml` for what each field means. No `factory.yml`: stop and point to `/software-factory:setup`.
2. Quick drift check: each stage's folder (local) exists, and every persona file resolves (below). Anything missing: stop and point to `/software-factory:setup` to plan and apply.
3. If `factory/state/run.lock` exists and is under 2 hours old, stop: another pass is running. Otherwise write it, and delete it when the pass ends, even on failure.
4. Make sure the main checkout is on the default branch and up to date.

## Rules

- **Only you move tickets** (move the file, or set the tracker `status` and swap the stage `label`) and edit frontmatter. After each move, add a History line: `- <date> <from> → <to>: <one-line reason>`.
- **Moving to an earlier stage** adds 1 to `tries`. If `tries` reaches `maxTries`, move it to the first `human` stage instead, with the failure notes.
- **Personas** run as general-purpose subagents (`Agent`). A persona's instructions are `${CLAUDE_SKILL_DIR}/../../personas/<name>.md` followed by `factory/personas/<name>.md` if it exists; if the project file's frontmatter has `replace: true`, only the project file. The ticket template resolves the same way (`ticket-template.md`, `factory/ticket-template.md`). Brief each persona with those file paths (it reads them first), the ticket (path, or tracker id plus connector), its worktree path if any, the template path, and the config values it needs. It adds only to its own section of the ticket (on a tracker: a comment headed with that section) and ends with `VERDICT: <value> - <reason>`. Run personas for different tickets in parallel, up to a stage's `limit`.
- **Actions** (`do` and `before`):
  - `create-worktree`: new branch `factory/<id>` from the default branch, in `<repo>.worktrees/<id>` next to the repo; set `branch`.
  - `open-pr`: with a git host, push the branch and open a PR (title from the ticket, body links it); set `pr`. No host: nothing.
  - `sync-branch`: merge the default branch into the ticket's branch. A conflict you can't resolve cleanly sends the ticket back to the first `persona` stage after the `queue` (where code is built).
  - `merge`: merge the PR with the git host connector, or merge the branch locally with no host.
  - `label-human-review`: add the `human-review` label to the PR (no host: nothing).
  - `remove-worktree`: remove the ticket's worktree.

## The pass

Work through `stages` **from last to first**, so finished work frees slots before new work starts and each ticket moves at most one stage:

- `end`: nothing.
- `human`: a ticket whose PR or branch has been merged moves to `next`. A PR closed without merging: leave it and report it.
- `persona`: run `before` actions, then the persona on each ticket (oldest first, at most `limit`). Route the verdict through `on`, running the route's `do` actions. For a route with `daily`, first tell the persona how many moves remain today (`daily` minus today's History lines for that move); over the cap it should answer `wait`. A verdict with no route (such as `wait`), a crash or no verdict: the ticket stays; report crashes. Set `severity` when the verdict gives one.
- `queue`: while fewer than `wip` tickets sit in later `persona` stages, pick up the highest `severity` ticket (unset counts as `medium`), oldest first, and move it along `next`, running its `do` actions.
- `gate`: move tickets whose `- [x] <gate>` box is ticked to `next`.

Then run `sources` in parallel (skip `gatherer` while `telemetry` is empty). They create tickets in their `into` stage; the next pass handles them.

## Report

A short table: ticket, from → to, reason. Then what waits on the user: tickets in `gate` stages to refine, tickets in `human` stages with their PR links, and anything that failed.
