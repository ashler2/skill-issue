---
name: trim
description: Cut what a skill, plugin, CLAUDE.md/AGENTS.md, agent or hook costs in context without changing what it does.
argument-hint: "<skill, plugin or file>"
disable-model-invocation: true
---

Make the target (none: ask) as small as it can be while keeping its behaviour.

1. **Measure.** Plugin or plugin skill: `claude plugin details <plugin>` (local, uncommitted: `claude --plugin-dir <dir> plugin details <name>`). Any other file: estimate words × 1.3. Note always-on and per-use cost apart; hook output counts per firing.
2. **Find cuts**, each with its reason:
   - restates a tool's own schema or Claude's defaults
   - says something twice
   - detail only some runs need: move it to a separate file behind a pointer
   - an always-on description longer than it needs to trigger
3. **Never cut** a behaviour, a rule someone chose on purpose, or a line marked keep (check the project's `CLAUDE.md` notes on the target).
4. Show the cuts, before → after, and ask with `AskUserQuestion` (multi-select) which to apply. Apply only those.
5. Re-measure. Report before → after per cost line. In a plugin, bump its `version` and update any cost notes in `CLAUDE.md`.
