---
name: retro
description: Look back on a session or feature, find what went wrong or slow, and turn it into small rule changes you pick.
argument-hint: "[session (default), branch, range or notes]"
disable-model-invocation: true
---

Turn what went wrong into rules so it doesn't happen again. Nothing changes until the user picks.

## 1. Find what went wrong

Scope: this session, or the given branch, commit range or notes. Look for:

- corrections from the user, and work they rejected or undid
- repeated failed attempts, reverts and fix-up commits
- rules or instructions that existed but were missed
- slow paths: long searches for something a note could have pointed to
- surprises: setup, commands or behaviour nobody expected

Also note anything the user confirmed worked well and isn't recorded yet.

For each one, find the **cause**: a missing rule, an unclear or badly placed rule, a wrong default, or a one-off that needs nothing. If a rule already covers it, fix its wording or place instead of adding another.

## 2. Propose fixes

One fix per cause, in the smallest lasting place:

- the project's `CLAUDE.md`/`AGENTS.md` (outside any generated block) for project facts and rules
- the skill, agent or hook that misbehaved
- the user's memory or global instructions for personal preferences across projects
- nothing, for one-offs: say so

Each fix is a short before → after edit, says each thing once, and doesn't restate Claude's defaults. Give its cost in tokens (words × 1.3) and whether it loads every session or only on use.

## 3. Apply

Show the findings as a short table (what happened, cause, fix, cost). Ask with `AskUserQuestion` (multi-select) which fixes to apply. Apply only those. If a fix edits a plugin, bump its `version`.

Finish with the files changed and the total tokens added. Don't commit unless asked.
