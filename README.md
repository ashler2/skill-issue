# skill-issue

A personal collection of [Claude Code skills](https://docs.claude.com/en/docs/claude-code/skills).

## Layout

```
skills/
  <skill-name>/
    SKILL.md        # frontmatter (name, description) + instructions
    ...             # any scripts, references or templates the skill uses
```

## Using a skill

Symlink (or copy) a skill folder into your personal skills directory:

```bash
ln -s "$PWD/skills/<skill-name>" ~/.claude/skills/<skill-name>
```
