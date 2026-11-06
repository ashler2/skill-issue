---
name: refine
description: Refine a software-factory feature with the user until it's ready for development - a grilling interview whose answers are written into the ticket.
disable-model-invocation: true
argument-hint: "[feature file, ticket id, or a new idea in plain words]"
---

Refine one feature ticket in the factory's first `gate` stage (`features` by default). Read `factory/factory.yml` first; if it's missing, stop and point to `/software-factory:setup`. Never write code here.

## 1. Pick the ticket

- **A file or ticket id**: open it from that stage (local: `factory/tickets/<stage id>/`; tracker: its status, stage label and the opt-in label).
- **Plain words**: a new feature. Create it from the ticket template (`factory/ticket-template.md` if it exists with `replace: true`, else `${CLAUDE_SKILL_DIR}/../../ticket-template.md` plus any project additions) with `type: feature`, `source: human` and a short slug `id`, in that stage. On a tracker, create it with the opt-in label and the stage's status and label.
- **Nothing**: list the unfinished features and ask which.

## 2. Grill

Read the ticket and the parts of the codebase it touches. Then interview the user until a developer could build it without guessing:

- One question per turn with `AskUserQuestion`, the highest-stakes open decision first (most expensive to get wrong). End it with **Why it matters:** and the failure it guards against. Say once that **Other** takes `skip` or `explain`.
- Look facts up yourself (code, docs); ask the user only for decisions.
- Push back once on an answer that contradicts an earlier one or dodges; the decision is theirs.
- "I don't know" is an answer: record it as an open question.
- If the feature is really several, offer to split it into separate feature tickets.

After each answer, update the ticket so stopping loses nothing:
- **Summary**: what and why.
- **Acceptance criteria**: observable, testable results; the developer writes tests from these first.
- **Refinement notes**: each decision with its reason, then open questions.

## 3. Finish

Show the Summary, Acceptance criteria and any open questions. Ask whether it's ready for development. Tick the stage's `gate` box (`- [x] Ready for development` by default) only on a clear yes; if open questions remain, say so before asking. Add a History line (`<date> refined by human`). `/software-factory:run` moves ticked tickets on.
