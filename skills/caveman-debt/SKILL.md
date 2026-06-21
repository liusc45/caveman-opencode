---
name: caveman-debt
description: Harvest every `caveman:` shortcut comment in the codebase into a debt ledger, so deliberate deferrals get tracked instead of rotting into "later means never". Use when user says "caveman debt", "/caveman-debt", "what did caveman defer", "list the shortcuts", "caveman ledger", "qué dejamos para después", or invokes /caveman-debt. One-shot report, changes nothing.
metadata:
  origin: opencode
  effort: low
---

# Caveman Debt

Every deliberate caveman shortcut is marked with a `caveman:` comment naming its ceiling and upgrade path. This collects them into one ledger so a deferral can't quietly become permanent. Reply in user's language (ES/EN).

## Scan

Grep the repo for comment markers, skipping `node_modules`, `.git`, and build output:

`grep -rnE '(#|//|--|;) ?caveman:' .` (covers `#`, `//`, `--` SQL/Lua, `;` Lisp/asm; add other comment prefixes if your stack uses them)

Each hit is one ledger row. The comment prefix keeps prose that merely mentions the convention out of the ledger.

## Output

One row per marker, grouped by file:

`<file>:<line>, <what was simplified>. ceiling: <the limit named>. upgrade: <the trigger to revisit>.`

The convention is `caveman: <ceiling>, <upgrade path>`, so pull the ceiling and trigger straight from the comment. Want an owner per row? add `git blame -L<line>,<line>`.

Flag the rot risk: any `caveman:` comment that names no upgrade path or trigger gets a `no-trigger` tag — those silently rot.

End with `<N> markers, <M> with no trigger.` Nothing found: `No caveman: debt. Clean ledger.`

## Boundaries

Reads and reports only, changes nothing. To persist it, ask and it writes the ledger to a file (e.g. `CAVEMAN-DEBT.md`). One-shot. "stop caveman" or "normal mode" to revert.
