---
name: explain-to-me
description: Explain a change, feature or bug fix in three layers, from non-technical to technical, grounded in the actual diff.
disable-model-invocation: true
---

Explain a change so anyone can follow it. The **diff** is the source of truth for *what* changed; the conversation, commit messages and PR text supply *why*.

## 1. Find the change

The **target** is whatever the user typed after `/explain-to-me`: a commit, a range, a branch, a PR number, a file, a Linear ticket like `ASH-123`, or plain words like "the login fix". Resolve it to a concrete diff with `git`, `gh` or the Linear tools. When it could mean more than one change, list the candidates and ask which.

With no target, explain **this session's work**: every file this conversation changed, committed or not, read from the diff. When this session changed nothing, fall back in order to uncommitted changes, then the current branch against `main`, then the last commit. Say in one line which one you picked.

Read the whole diff before writing. For anything wider than a few files, use a subagent to summarise it.

## 2. Check the story against the diff

Compare what the conversation says was done with what the diff shows. When they disagree, explain the diff, and open the explanation with a **Heads up** listing:
- anything claimed but missing from the diff
- anything changed but never mentioned

Leave the Heads up out when they agree.

## 3. Sort the change

Split the diff into **parts**: changes with separate purposes. Give each part a **kind**, which sets how every layer frames it:

| Kind | Frame every layer as |
| --- | --- |
| Feature | What you can do now that you couldn't before |
| Bug fix | What was broken, why it broke, what fixed it |
| Behind the scenes (refactor, config, dependencies, tests) | What changed underneath, and why it was worth doing when nothing looks different |

## 4. Write the explanation

When there are several parts, start with an **Overview**: one line per part. Then write these sections for each part in turn, under a heading naming the part:

1. **In a nutshell**: for someone non-technical. 2–3 sentences, everyday words, an analogy where it helps. No file names, no jargon.
2. **What this means**: for the developer who asked. A short paragraph or a few bullets in plain English. Name files and concepts when useful, and explain each term the first time it appears.
3. **Under the hood**: technical. As long as it needs: files changed, the key functions, classes or queries, and how they fit together. Reference code as `path:line`.
4. **See it working**: numbered steps to check the change yourself: what to open, run or click, and what you should now see. For a change with nothing visible, give the command or test that proves it, or say plainly that there's nothing visible to check.

The length limits on the first two layers are firm: when a part needs more, the extra goes in **Under the hood**.

## 5. Deliver

Write the explanation in chat. Write it to a file only when the user asks: by default `explanations/YYYY-MM-DD-<short-slug>.md` at the project root, or the path they give. Tell them where it went.
