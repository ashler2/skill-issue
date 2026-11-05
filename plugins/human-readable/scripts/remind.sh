#!/bin/bash
# PostToolUse hook: after an edit to a code, template or markup file,
# add a one-line reminder to Claude's context. Other files get nothing.

hook_input=$(cat)

# Pull the edited file's path out of the hook's JSON input without needing jq.
edited_file=$(printf '%s' "$hook_input" \
  | grep -o '"\(file_path\|notebook_path\)"[[:space:]]*:[[:space:]]*"[^"]*"' \
  | head -n 1 \
  | sed 's/.*:[[:space:]]*"\(.*\)"/\1/')

extension="${edited_file##*.}"
extension=$(printf '%s' "$extension" | tr '[:upper:]' '[:lower:]')

code_extensions=" php js mjs cjs ts tsx jsx vue svelte astro py rb go rs java kt kts scala swift m mm c h cc cpp hpp cs fs dart ex exs erl clj lua luau gd sh bash zsh fish ps1 sql graphql gql html htm twig erb hbs handlebars mustache liquid njk ejs pug xml svg css scss sass less styl "

# Notebooks are code too.
if [ "$extension" = "ipynb" ] || [[ "$code_extensions" == *" $extension "* ]]; then
  printf '%s\n' '{"hookSpecificOutput":{"hookEventName":"PostToolUse","additionalContext":"human-readable: check this edit against the human-readable skill (load it if needed) and fix what falls short."}}'
fi

exit 0
