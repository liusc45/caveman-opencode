---
description: Caveman code review of the current diff — terse, actionable, covers bugs AND over-engineering, no edits
agent: caveman-reviewer
---

Load the caveman-review skill rules.

Review the current diff in caveman mode across two scopes: correctness (bugs/risks/nits) and over-engineering (what to delete: reinvented stdlib, needless deps, speculative abstractions). If `$ARGUMENTS` is empty, review all uncommitted changes against HEAD (run `git diff HEAD`); otherwise run `git diff $ARGUMENTS`. One line per finding: location, problem, fix. End the over-engineering pass with `net: -<N> lines possible.` Don't write fixes, don't approve. Output comments ready to paste.
