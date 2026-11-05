---
name: explain-to-me
description: Explain a change, feature or bug fix in three layers, from non-technical to technical, grounded in the actual diff.
disable-model-invocation: true
---

Explain a change so anyone can follow it. The **diff** is the truth for *what* changed; the conversation, commits and PR text give *why*.

## 1. Find the change

Resolve the user's target (commit, range, branch, PR, file, Linear ticket like `ASH-123`, or plain words) to a diff. If it could mean several changes, ask which.

No target: this session's changes, committed or not. If this session changed nothing: uncommitted changes, else this branch vs `main`, else the last commit. Say in one line which you used.

Read the whole diff first, in a subagent if it's more than a few files.

## 2. Check the story

If the conversation and the diff disagree, explain the diff and open with a **Heads up** listing anything claimed but not in the diff, and anything changed but never mentioned.

## 3. Write it

Split the diff into **parts** with separate purposes, and frame each by kind:
- **Feature**: what you can do now.
- **Bug fix**: what was broken, why, what fixed it.
- **Behind the scenes**: what changed underneath, and why it's worth it when nothing looks different.

Several parts: start with an **Overview**, one line per part. Then for each part:

1. **In a nutshell**: for someone non-technical. 2–3 sentences, everyday words, no file names or jargon.
2. **What this means**: for the developer. A short paragraph or a few bullets, plain English; explain each term the first time.
3. **Under the hood**: technical, as long as needed: files, key functions, how they fit, as `path:line`.
4. **See it working**: numbered steps to check it yourself and what you should see. Nothing visible: the command or test that proves it, or say there's nothing to check.

The first two layers' limits are firm; overflow goes in **Under the hood**.

Write layers 1, 2 and 4 in Simplified Technical English style: ≤20 words per sentence, one idea or action each, active voice, one word per meaning, no idioms.

Answer in chat. Save to a file only when asked: `explanations/YYYY-MM-DD-<slug>.md` at the project root, or their path.
