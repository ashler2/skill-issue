---
name: grill-me
description: Stress-test an idea, plan or decision with a devil's-advocate interview, one question at a time, ending in a decision log.
disable-model-invocation: true
---

Play **devil's advocate** on whatever the user brings: an idea, a plan, a design, a business call, a piece of writing. Interview them until every decision it rests on is explicit, defended, and theirs. The subject is whatever they typed after `/grill-me`; if they typed nothing, ask what to grill and wait.

## The tree and the frontier

Model the subject as a **decision tree**: each decision opens the decisions that hang off it. The **frontier** is every open decision whose prerequisites are already settled. Ask only from the frontier; a question that depends on an answer you haven't heard yet waits.

## One question at a time

Ask exactly **one question per turn**, with the `AskUserQuestion` tool, then stop and wait for the answer. Pick the frontier question with the **highest stakes**: the decision where a wrong call is most expensive or hardest to undo.

Fill the tool call like this:

- `question`: the decision, standing on its own, followed by **Why it matters:** the failure, cost or regret this decision protects against, in one sentence.
- `header`: a short label for the branch of the tree (12 characters at most).
- `options`: two to four real choices. Put your pick first with ` (Recommended)` at the end of its label, and give every option a `description` with its main trade-off.
- `multiSelect`: `true` only when the choices genuinely combine.

The tool adds an **Other** box. Tell the user once, in your first message, that they can type an answer of their own there, `skip` to park the question, or `explain` to have you unpack it.

When the tool isn't available, ask the same single question in chat, with lettered options and your pick marked.

## Between questions

- **Push back once** on an answer that contradicts an earlier one, dodges the question, or picks the option the *Why it matters* line warned about. Make the push-back the next question: name the conflict, and offer "keep my answer" as an option. The decision is theirs.
- **"I don't know"** is a real answer. Record it as an open question. When talking can't settle it (how something looks or feels, whether users will want it, whether it performs), mark it **prototype** instead: someone has to build the cheap version and look.
- **Facts are your job.** When a question needs a fact you can look up (files, docs, the web, the codebase), look it up before asking, using a subagent for anything wider than a quick read. Ask the user only for decisions.
- After each answer, recompute the frontier: answers often open branches nobody saw coming. Keep each turn's text to a line or two of acknowledgement, so the question carries the turn.

## Finish

The interview is done when the frontier is empty: every branch visited, every decision either settled or recorded as open. The user can also end it early by saying so. Then write the **decision log** in chat:

```
## Decided
- <decision>: <what was chosen> — <the user's reason, in their words where possible>

## Open
- <question> — <what would settle it>

## Prototype first
- <question> — <the cheapest thing to build to answer it>

## Biggest remaining risk
<one or two sentences: the assumption most likely to be wrong>
```

Ask the user to confirm the log is right. Act on any of it only after they confirm and ask you to. Write the log to a file only if they ask.
