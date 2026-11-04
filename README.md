# skill-issue

A personal collection of [Claude Code skills](https://docs.claude.com/en/docs/claude-code/skills).

## Layout

```
skills/
  <skill-name>/
    SKILL.md        # frontmatter (name, description) + instructions
    ...             # any scripts, references or templates the skill uses
```

## Install

This repo is both a Claude Code plugin and a one-plugin marketplace. In Claude Code:

```
/plugin install skill-issue --marketplace ashler2/skill-issue
```

On older versions, add the marketplace first:

```
/plugin marketplace add ashler2/skill-issue
/plugin install skill-issue@skill-issue
```

Every folder in `skills/` becomes a skill once the plugin is installed. Run `/plugin` and pick **Update** to get new skills after pushing.

The repo is private, so the machine installing it needs GitHub access (`gh auth login` or an SSH key).

## Adding a skill

1. Create `skills/<skill-name>/SKILL.md` with `name` and `description` frontmatter.
2. Bump `version` in `.claude-plugin/plugin.json`.
3. Run `claude plugin validate .`, then commit and push.
