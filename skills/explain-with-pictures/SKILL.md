---
name: explain-with-pictures
description: Explain a change like explain-to-me, adding pictures where words struggle. Levels are mermaid (default) or screenshots.
argument-hint: "[mermaid|screenshots] [what]"
disable-model-invocation: true
---

Read `${CLAUDE_SKILL_DIR}/../explain-to-me/SKILL.md` and follow it, with the additions below.

## Level

If the first word of the arguments is `mermaid` or `screenshots`, that is the level and the rest is the target. Otherwise the level is `mermaid`. Say the level in the same line as the target.

- **mermaid**: Mermaid diagrams only.
- **screenshots**: Mermaid diagrams plus screenshots of the feature.

## When to draw

Draw a picture only where it says something faster than words: a flow, an order of events, a structure, a before and after. Skip it where one sentence does the job. A small change can have no pictures; say so in one line.

## Mermaid

- **In a nutshell**: at most one tiny diagram (≤6 boxes), everyday words, no code names. Before/after works well.
- **Under the hood**: use the type that fits: `flowchart`, `sequenceDiagram`, `classDiagram`, `erDiagram`, `stateDiagram-v2`. Real names from the diff. ≤15 nodes; split bigger ones.
- Put each diagram in a ` ```mermaid ` block under the text it supports. Quote labels that hold brackets, colons or quotes. Mark what changed (`:::new`, a `classDef`, or "(new)" in the label).

## Screenshots

- Only for parts a user can see. Behind-the-scenes parts get Mermaid only.
- Run the app the project's way (its `CLAUDE.md`, or a run skill). Capture with the browser, simulator or screenshot tool the session has. Show the changed screen in the state the change affects.
- Add a "before" shot only when you can get it without touching the user's working tree.
- Save PNGs in the session's scratchpad (or a temp folder), or in `explanations/img/` when the explanation goes to a file. Show each one to the user: a send-file tool if there is one, otherwise a markdown image with its path. Add a one-line caption.
- Can't run or capture it: say why in one line and use Mermaid instead.
