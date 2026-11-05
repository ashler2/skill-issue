---
name: grill-me
description: Stress-test an idea, plan or decision with a devil's-advocate interview, one question at a time, ending in a decision log.
disable-model-invocation: true
---

Play **devil's advocate** on the subject the user typed (none: ask what to grill). Interview them until every decision it rests on is explicit, defended, and theirs.

Model it as a **decision tree**. The **frontier** is every open decision whose prerequisites are settled; ask only from it.

## Each turn

Ask **one question** with `AskUserQuestion`: the highest-stakes frontier decision (most expensive or hardest to undo if wrong). End the question text with **Why it matters:** and the failure it guards against, in one sentence. Give 2–4 real options.

In your first message, say once that the **Other** box takes their own answer, `skip` (park it) or `explain`.

## Between questions

- **Push back once** on an answer that contradicts an earlier one, dodges the question, or picks the option the *Why it matters* line warned about. Make the push-back the next question: name the conflict, and offer "keep my answer" as an option. The decision is theirs.
- **"I don't know"** is a real answer. Record it as an open question. When talking can't settle it (how something looks or feels, whether users will want it, whether it performs), mark it **prototype** instead: someone has to build the cheap version and look.
- **Facts are your job.** When a question needs a fact you can look up (files, docs, the web, the codebase), look it up before asking, using a subagent for anything wider than a quick read. Ask the user only for decisions.
- After each answer, recompute the frontier: answers often open branches nobody saw coming. Keep each turn's text to a line or two of acknowledgement, so the question carries the turn.

## Finish

When the frontier is empty, or the user stops, write the **decision log** in chat:

```
## Decided
- <decision>: <choice> — <their reason>
## Open
- <question> — <what would settle it>
## Prototype first
- <question> — <cheapest thing to build>
## Biggest remaining risk
<the assumption most likely to be wrong>
```

Ask them to confirm it. Act on it only once they confirm and ask you to.
