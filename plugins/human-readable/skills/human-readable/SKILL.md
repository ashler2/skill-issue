---
name: human-readable
description: Readable-code rules. Use when writing or editing code, templates or markup.
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

Write code a person can read once and understand. The project's own conventions (`CLAUDE.md`/`AGENTS.md`, linters, conventions skills, the surrounding code's style) win; these rules fill what they leave open.

## Rules

**Names.** Full words for what it holds or does: `invoiceTotal`, `sendReminderEmail`, `isExpired`. Single letters only for loop counters and idioms (`i`, `e`, `x`/`y`). Replace vague names (`data`, `result`, `temp`, `info`, `handle`, `process`, `manager`, `util`) with the specific thing.

**Only what the task needs.** The smallest change that does the job. Add an option, parameter, wrapper, interface, flag or abstraction only when this task uses it. Three similar lines beat a premature helper. Delete code your change leaves unused.

**Simple structure.** Short functions doing one thing. Return early instead of nesting. A plain `if`/`else` or a named variable over a chained ternary, dense one-liner or clever trick.

**Comments explain why.** Comment the reason behind anything non-obvious: a workaround, a business rule, an edge case. Let names say what. Leave out comments that restate the code or narrate your change.

## Existing code

Keep your diff to the task. Mention badly unreadable code you touch in one line (file and problem) instead of fixing it.

## Clean-up mode

`/human-readable <file, folder or "this diff">`: rewrite the target to these rules with behaviour unchanged. Keep public names other code calls; rename private ones freely. Run the project's tests and linter for the changed files, fix what you broke, then summarise the changes in a few bullets. No target: ask what to clean up.
