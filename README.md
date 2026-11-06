<p align="center"><img src="assets/logo.svg" alt="skill-issue logo: a d20 that rolled a 1" width="160"></p>

# skill-issue

A collection of general-purpose [Claude Code skills](https://docs.claude.com/en/docs/claude-code/skills).

## Skills

| Skill | Invoke | What it does |
| --- | --- | --- |
| [grill-me](skills/grill-me/SKILL.md) | `/grill-me <idea>` | Devil's-advocate interview, one question at a time with Claude's built-in question picker, highest stakes first, ending in a decision log of what's decided, open, and worth prototyping. |
| [explain-to-me](skills/explain-to-me/SKILL.md) | `/explain-to-me [what]` | Explains a change, feature or bug fix in three layers (non-technical, plain English, technical) plus how to see it working. Defaults to this session's work; checks the story against the actual diff. |
| [explain-with-pictures](skills/explain-with-pictures/SKILL.md) | `/explain-with-pictures [mermaid\|screenshots] [what]` | Same as explain-to-me, plus pictures where words struggle. `mermaid` (default) adds diagrams; `screenshots` also runs the app and captures the changed screens. |
| [trim](skills/trim/SKILL.md) | `/trim <skill, plugin or file>` | Measures what a skill, plugin, `CLAUDE.md`/`AGENTS.md`, agent or hook costs in context, proposes cuts that keep its behaviour, applies the ones you pick and shows before → after. |
| [blast-radius](skills/blast-radius/SKILL.md) | `/blast-radius <change>` | Before a risky change, maps everything it reaches: what must change, what might break, data and users at risk, test coverage and blind spots. Ends with a risk level and a safe order. Changes nothing. |
| [setup](skills/setup/SKILL.md) | `/skill-issue:setup` | Shows the optional plugins below, and switches them on or off: everywhere, for a project, or just for you in a project. |

## Optional plugins

These live in the same marketplace but are installed separately, because they change how Claude works all the time. Switch them on with `/skill-issue:setup`, or directly with `claude plugin install <name>@skill-issue`.

| Plugin | What it does |
| --- | --- |
| [human-readable](plugins/human-readable/skills/human-readable/SKILL.md) | Rules for readable code (clear names, only what the task needs, simple structure, comments that explain why). They load automatically the first time Claude touches a code, template or markup file, and a hook reminds Claude to re-check after every edit to one. Project conventions win where they clash. `/human-readable <file, folder or "this diff">` cleans up existing code without changing what it does. |
| [the-ladder](plugins/the-ladder/skills/the-ladder/SKILL.md) | Before writing code, Claude climbs a ladder and stops at the first rung that works: does it need to exist, is it already in the codebase, does a built-in or installed package do it, then build it (shared only if a second caller needs it today) with the least code. Before changing a shared function it checks every caller and fixes the root cause once. Each coding reply ends with the rung it used. A one-line hook at session start makes sure it loads; say "stop ladder" to turn it off for a session. |
| [software-factory](plugins/software-factory/skills/setup/SKILL.md) | A software factory defined as code in a committed `factory/factory.yml`: ticket source (a local folder, Linear, GitHub or Jira), git host, telemetry, tests, limits and the stage graph itself (default: features → triage → ready → in-progress → qa → review → evaluate → merged or human-review). Projects can extend or replace any persona or the ticket template in `factory/personas/`. `/software-factory:setup` writes the file, then plans and applies what it needs, like Terraform; re-run it after editing. `/software-factory:refine [feature]` interviews you about a feature and ticks it ready. `/software-factory:run` runs one pass: sources (telemetry gatherer, code hunter) create tickets and every ticket moves one stage with persona subagents (developer, QA, reviewer, evaluator, ...). Repeat it with `/loop` or a schedule. |

## Layout

```
.claude-plugin/
  plugin.json       # plugin manifest (name, version, description)
  marketplace.json  # marketplace: skill-issue plus the optional plugins
  icon.png          # plugin icon
assets/
  logo.svg          # logo
plugins/
  human-readable/   # optional plugin: its own .claude-plugin/, skills/, hooks/, scripts/
  the-ladder/       # optional plugin: its own .claude-plugin/, skills/, hooks/
  software-factory/ # optional plugin: its own .claude-plugin/, skills/, plus defaults.yml, personas/, ticket-template.md
skills/
  <skill-name>/
    SKILL.md        # frontmatter (name, description) + instructions
    ...             # any scripts, references or templates the skill uses
```

## Install

This repo is a Claude Code plugin and also its own marketplace, so Claude Code can install it straight from GitHub. It works wherever Claude Code runs: the terminal, the Code tab in the Claude desktop app, and the VS Code and JetBrains extensions all share the same plugins.

### Before you start

- Claude Code is installed and signed in.

### Option 1: inside a Claude Code session

Type this into Claude Code:

```
/plugin install skill-issue --marketplace ashler2/skill-issue
```

If your version doesn't know `--marketplace`, add the marketplace first, then install:

```
/plugin marketplace add ashler2/skill-issue
/plugin install skill-issue@skill-issue
```

### Option 2: from the terminal

```bash
claude plugin marketplace add ashler2/skill-issue
claude plugin install skill-issue@skill-issue
```

Add `--scope project` to the install to enable it only for the current project (saved in `.claude/settings.json`, so teammates get it too), or `--scope local` for just you in that project. The default, `user`, enables it everywhere.

### Option 3: enable it for a project automatically

Add this to a project's `.claude/settings.json`. Anyone who opens the project in Claude Code is asked to install the marketplace and plugin:

```json
{
  "extraKnownMarketplaces": {
    "skill-issue": {
      "source": { "source": "github", "repo": "ashler2/skill-issue" }
    }
  },
  "enabledPlugins": {
    "skill-issue@skill-issue": true
  }
}
```

### Check it worked

Start a new Claude Code session, then run:

```bash
claude plugin list
```

`skill-issue@skill-issue` should be listed as enabled, and its skills show up when you type `/` in a session.

### Update

After new skills are pushed:

```bash
claude plugin marketplace update skill-issue
claude plugin update skill-issue@skill-issue
```

Or run `/plugin` in a session and pick **Update**.

### Uninstall

```bash
claude plugin uninstall skill-issue@skill-issue
claude plugin marketplace remove skill-issue
```

## Adding a skill

1. Create `skills/<skill-name>/SKILL.md` with `name` and `description` frontmatter.
2. Bump `version` in `.claude-plugin/plugin.json`.
3. Run `claude plugin validate .`, then commit and push.
