---
name: setup
description: Set up the software factory as code - write factory/factory.yml (ticket source, stages, git host, telemetry, tests, limits), then plan and apply what it needs (folders, labels, statuses, gitignore). Re-run after editing the file.
disable-model-invocation: true
---

`factory/factory.yml` is the source of truth; this command makes the project match it, like `terraform init` + `plan` + `apply`. The defaults, with every field explained, are in `${CLAUDE_SKILL_DIR}/../../defaults.yml`. Read it first.

For every connector: use what already works (a connected MCP server or an authenticated CLI), do a test read, and if nothing works say how to connect one.

## 1. Init (only when `factory/factory.yml` doesn't exist)

Copy `defaults.yml` to `factory/factory.yml`, keeping its comments, then fill it in by asking:

1. **Tickets**: local folder, Linear, GitHub or Jira. Local: say once that local tickets are gitignored, so they live only on this machine. Trackers: find the connector, ask where (team, `owner/repo` (default: this repo's remote), or project key) and the opt-in label (default `factory`). Then list the tracker's statuses and set each stage's `status`, suggesting the closest match. When stages would share a status, ask whether to tell them apart with a `label` (`factory:<stage id>`) or to create the missing statuses (on Jira, a Jira admin must add them).
2. **Git host**: detect it from `git remote -v` and find its connector. No remote: `none`.
3. **Telemetry**: list connected error sources (such as a Sentry MCP server); ask which, and which project.
4. **End-to-end tests**: find the framework, test command, start command and URL, and confirm them. None: ask once whether to add Playwright now; if not, `none`.
5. **Limits**: confirm `wip`, `maxTries` and triage's `daily`. For `alwaysHuman`, suggest globs that exist in this project (migrations, auth, payments, dependency manifests, CI, infrastructure).

Keep the default stages unless the user asks to change them.

## 2. Validate

Check `factory/factory.yml` and stop with clear errors if any fail:
- Every stage has a unique `id` and a known `type`; every `next`, `on` target and source `into` names a stage; exactly one `end` stage.
- Each `persona` exists as `${CLAUDE_SKILL_DIR}/../../personas/<name>.md` or `factory/personas/<name>.md`.
- On a tracker, every stage has a `status`, and stages sharing one have different `label`s.
- Actions are only the ones listed in `defaults.yml`.
- If `defaults.yml` has a top-level key the project file lacks (the plugin got newer), list it and offer to add it with its default.

## 3. Plan

Compare the project with the file and show a plan, like `terraform plan`: what will be created or changed, and why. Possible items:
- Local: `factory/tickets/<stage id>/` for each stage (and a note for each folder with tickets whose stage was removed).
- Trackers: the opt-in label, stage labels, statuses, and the git host's `human-review` label.
- `.gitignore` (only if it exists): `factory/tickets/` and `factory/state/`.
- Customising: say that `factory/personas/<name>.md` adds rules to a persona (or replaces it when its frontmatter has `replace: true`), and `factory/ticket-template.md` does the same for the template.

Nothing to change: say the factory matches its config, and stop.

## 4. Apply

Ask once to apply the whole plan, then do it. Never delete tickets or folders that hold tickets; report them instead. Finish with a table of stages and their mapping, and how to hand the factory work: a ticket in the first `gate` stage (refine it with `/software-factory:refine`), or the opt-in label on a tracker ticket. Remind the user to commit `factory/factory.yml` and any `factory/personas/` files.
