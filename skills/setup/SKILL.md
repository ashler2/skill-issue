---
name: setup
description: Show, switch on or switch off skill-issue's optional plugins, like human-readable.
disable-model-invocation: true
---

Manage the **optional plugins**: every plugin in the `skill-issue` marketplace except `skill-issue` itself.

1. Run `claude plugin marketplace update skill-issue`, then `claude plugin list --available --json`. Optional plugins not installed are in `available` (`marketplaceName` `skill-issue`); installed ones are in `installed` (`id` ending `@skill-issue`, with `scope` and `enabled`).
2. Show a table: plugin, one-line description, status (off / everywhere / this project for everyone / this project just for me).
3. Ask with `AskUserQuestion` which to switch on or off (multi-select). Then, for each one switched on, ask where: **everywhere** (`user`), **this project, for everyone** (`project`, committed in `.claude/settings.json`), or **this project, just for me** (`local`). Offer the project options only inside a project.
4. Apply: `claude plugin install <name>@skill-issue --scope <scope>`, or `claude plugin uninstall <name>@skill-issue --scope <its scope>`.
5. Show the updated table, and say the change applies from the next session.
