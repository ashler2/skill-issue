---
name: human-readable
description: Rules for writing human-readable code. Use whenever writing or editing code, templates or markup.
argument-hint: "[file, folder or \"this diff\" to clean up]"
paths:
  - "**/*.php"
  - "**/*.js"
  - "**/*.mjs"
  - "**/*.cjs"
  - "**/*.ts"
  - "**/*.tsx"
  - "**/*.jsx"
  - "**/*.vue"
  - "**/*.svelte"
  - "**/*.astro"
  - "**/*.py"
  - "**/*.rb"
  - "**/*.go"
  - "**/*.rs"
  - "**/*.java"
  - "**/*.kt"
  - "**/*.kts"
  - "**/*.scala"
  - "**/*.swift"
  - "**/*.m"
  - "**/*.mm"
  - "**/*.c"
  - "**/*.h"
  - "**/*.cc"
  - "**/*.cpp"
  - "**/*.hpp"
  - "**/*.cs"
  - "**/*.fs"
  - "**/*.dart"
  - "**/*.ex"
  - "**/*.exs"
  - "**/*.erl"
  - "**/*.clj"
  - "**/*.lua"
  - "**/*.luau"
  - "**/*.gd"
  - "**/*.sh"
  - "**/*.bash"
  - "**/*.zsh"
  - "**/*.fish"
  - "**/*.ps1"
  - "**/*.sql"
  - "**/*.graphql"
  - "**/*.gql"
  - "**/*.html"
  - "**/*.htm"
  - "**/*.twig"
  - "**/*.erb"
  - "**/*.hbs"
  - "**/*.handlebars"
  - "**/*.mustache"
  - "**/*.liquid"
  - "**/*.njk"
  - "**/*.ejs"
  - "**/*.pug"
  - "**/*.xml"
  - "**/*.svg"
  - "**/*.css"
  - "**/*.scss"
  - "**/*.sass"
  - "**/*.less"
  - "**/*.styl"
---

Write code a person can read once and understand. These rules apply to every line of code, template or markup you write.

## The project comes first

The project's own conventions win: its `CLAUDE.md` or `AGENTS.md`, its linters and formatters, any conventions skill, and the style of the surrounding code. These rules decide everything those leave open. Match the neighbours.

## The rules

**Names.** Name every variable, function, class and file for what it holds or does, in full words: `invoiceTotal`, `sendReminderEmail`, `isExpired`. Single letters are for loop counters and well-known idioms (`i`, `e` for an event, `x`/`y` for coordinates). Swap vague names like `data`, `result`, `temp`, `info`, `handle`, `process`, `manager` and `util` for the specific thing.

**Only what the task needs.** Write the smallest change that does the job. Add an option, parameter, wrapper, interface, config flag or abstraction only when the current task uses it today. Three similar lines beat a premature helper. Delete code your change makes unused.

**Simple structure.** Keep functions short and doing one thing. Return early instead of nesting. Prefer a plain `if`/`else` or a named intermediate variable to a chained ternary, a dense one-liner or a clever trick. Use the language's everyday features over its obscure ones.

**Comments explain why.** Comment the reason behind anything non-obvious: a workaround, a business rule, a surprising edge case. Let the names say what the code does. Leave out comments that restate the code, narrate your change ("// Updated to fix the bug"), or mark sections that the structure already shows.

## Existing code

Keep your diff to the task. When code you read or touch is badly unreadable, leave it as it is and mention it in your reply in a line, with the file and what's wrong, so the user can ask for a clean-up.

## Clean-up mode

When the user types `/human-readable` with a target (a file, a folder, or "this diff" for the current uncommitted changes), rewrite that code to the rules above:

1. Read the target and its tests. Note what it does now: inputs, outputs, side effects.
2. Rewrite it to the rules, keeping its behaviour exactly the same. Keep public names that other code calls unless the user says otherwise; rename private ones freely.
3. Run the project's tests and linter for the changed files, when it has them. Fix anything you broke.
4. Summarise what you changed in a few bullets, and anything you deliberately left alone.

With no target, ask what to clean up.
