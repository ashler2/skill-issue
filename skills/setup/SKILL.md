---
name: setup
description: Show, switch on or switch off skill-issue's optional plugins, like human-readable.
disable-model-invocation: true
---

Manage the **optional plugins** in the skill-issue marketplace: everything it lists besides `skill-issue` itself.

## 1. Show what's there

1. Refresh the marketplace: `claude plugin marketplace update skill-issue`.
2. Run `claude plugin list --available --json`.
   - `available` entries with `marketplaceName` `skill-issue`, except `skill-issue` itself, are the optional plugins not yet installed. They come with a `description`.
   - `installed` entries whose `id` ends in `@skill-issue` are installed. Each carries its `scope` and whether it's `enabled`.
3. Show a short table: plugin, what it does (one line), status (off, or on: everywhere / this project for everyone / this project just for me).

## 2. Ask what to change

Ask with the `AskUserQuestion` tool, one question at a time:

1. Which plugins to switch on or off (`multiSelect: true`, one option per optional plugin, its label saying whether picking it turns it on or off).
2. For each plugin being switched **on**, where:
   - **Everywhere** (`--scope user`): every project on this machine.
   - **This project, for everyone** (`--scope project`): saved in the repo's `.claude/settings.json`, so collaborators are offered it too.
   - **This project, just for me** (`--scope local`): saved in `.claude/settings.local.json`.

   Offer the two project options only inside a project folder.

When nothing needs changing, say so and stop.

## 3. Apply

- Switch on: `claude plugin install <name>@skill-issue --scope <scope>`
- Switch off: `claude plugin uninstall <name>@skill-issue --scope <scope it was installed at>`

Run `claude plugin list --json` again and show the new table. Plugin changes apply from the next session, so tell the user to start a new one.
