---
name: to-spec
description: Turn a grill-me session or idea into a spec split into vertical slices, as a document or as software-factory tickets.
argument-hint: "[doc|factory] [decision log, file or idea]"
disable-model-invocation: true
---

Turn decisions into a spec someone can build slice by slice. Never write code here.

## 1. Gather

Source, in order: the given file or text, else the latest grill-me decision log in this conversation. Nothing to go on: suggest `/grill-me` first and stop. Read the parts of the codebase the spec touches, so slices name real files and layers.

Mode: `doc` or `factory` if given first. Otherwise `factory` when `factory/factory.yml` exists and the user agrees, else `doc`.

## 2. Slice

Split the work into **vertical slices**:

- Each slice cuts through every layer it needs (data, logic, API, UI) and ends in one behaviour a user or caller can see.
- Each is testable as a whole: its acceptance criteria check end-to-end behaviour, not a layer in isolation.
- No horizontal slices ("add the tables", "build the API", "write the UI"). Setup goes inside the first slice that needs it.
- Slice 1 is the thinnest working path end to end. Each later slice adds one behaviour on top.
- Small: one reviewable change. Too big: split by behaviour (happy path first, then edge cases, errors, permissions).
- An **Open** question blocks only the slices it affects; a **Prototype first** item becomes a spike slice before them, ending in a decision, not shipped code.

Show the slice list (title, what you can see when it's done, depends on) and ask with `AskUserQuestion` whether to go ahead, merge or split any. Repeat until they agree.

## 3. Write the spec

Save `specs/YYYY-MM-DD-<slug>.md` (or the user's path):

```
# <feature>
## Goal
## Decisions
- <decision>: <choice> — <reason>
## Out of scope
## Open questions
## Slices
### 1. <title>
Result: <what you can see when it's done>
Acceptance criteria:
- [ ] <observable, testable result>
Touches: <layers and main files>
Depends on: <slice numbers or none>
## Risks
```

## 4. Factory mode

Also create one ticket per slice in the first `gate` stage, the way `/software-factory:refine` does: the template is `factory/ticket-template.md` if it has `replace: true`, else the software-factory plugin's `ticket-template.md` plus project additions. Set `type: feature`, `source: <spec path>`, a slug `id`. Fill **Summary** (slice result + link to the spec), **Acceptance criteria**, and **Refinement notes** (decisions that apply, then `Depends on: <ids>`). Add a History line `<date> created by to-spec`.

The factory has no dependency order, so tick `Ready for development` only on slices with nothing unmet and no open question, and only after a clear yes. Tell the user to tick the rest once what they depend on is merged.

## Finish

List the spec path, and in factory mode the tickets with their ids and which are ticked.
