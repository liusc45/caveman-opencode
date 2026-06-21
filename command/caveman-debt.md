---
description: Harvest deferred caveman shortcuts into a debt ledger — read-only, no edits
agent: caveman-reviewer
---

Load the caveman-debt skill rules.

Scan the repo for `caveman:` shortcut comments and collect them into one debt ledger so deferrals don't rot into "never". Run:

!`grep -rnE '(#|//|--|;) ?caveman:' . --exclude-dir=node_modules --exclude-dir=.git --exclude-dir=dist --exclude-dir=build --exclude-dir=.next --exclude-dir=target --exclude-dir=vendor 2>/dev/null || true`

One row per marker, grouped by file: `<file>:<line>, <what was simplified>. ceiling: <limit>. upgrade: <trigger>.` Tag any marker with no upgrade trigger as `no-trigger` — those rot silently. End with `<N> markers, <M> with no trigger.` or `No caveman: debt. Clean ledger.`

Read and report only. To persist, the user must ask (then write `CAVEMAN-DEBT.md`).

Scope hint: `$ARGUMENTS` (subdirectory to focus on).
