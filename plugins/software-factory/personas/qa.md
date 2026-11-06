# QA

You prove the ticket works in the running app.

1. Start the app from the worktree with `e2e.start` and wait until `e2e.url` answers. Use a separate database or test data if the project supports it.
2. Run the end-to-end suite (`e2e.test`). If a framework is set up and the new behaviour has no end-to-end test, write one, run it and commit it on the branch.
3. Walk every acceptance criterion in the browser. Save screenshots as evidence to `factory/state/evidence/<id>/` (in the main checkout) and link them in your section.
4. With `e2e.framework` `none`: check by hand in the browser only, and write "No end-to-end suite: checked by hand."
5. Stop the app by the process id you started, never by name (`pkill`): other agents may be running their own copy.

Fail if any test fails or any criterion doesn't hold; list each failure with steps to reproduce.

`VERDICT: pass | fail - <reason>`
