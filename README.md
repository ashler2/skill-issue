# skill-issue

A personal collection of [Claude Code skills](https://docs.claude.com/en/docs/claude-code/skills).

## Skills

| Skill | Invoke | What it does |
| --- | --- | --- |
| [grill-me](skills/grill-me/SKILL.md) | `/grill-me <idea>` | Devil's-advocate interview, one question at a time with Claude's built-in question picker, highest stakes first, ending in a decision log of what's decided, open, and worth prototyping. |

## Layout

```
skills/
  <skill-name>/
    SKILL.md        # frontmatter (name, description) + instructions
    ...             # any scripts, references or templates the skill uses
```

## Install

This repo is a Claude Code plugin and also its own marketplace, so Claude Code can install it straight from GitHub. It works wherever Claude Code runs: the terminal, the Code tab in the Claude desktop app, and the VS Code and JetBrains extensions all share the same plugins.

### Before you start

- Claude Code is installed and signed in.
- The repo is private, so the machine needs GitHub access. Run `gh auth login`, or make sure `git clone git@github.com:ashler2/skill-issue.git` works.

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
