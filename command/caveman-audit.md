---
description: Caveman over-engineering audit of the WHOLE repo (not just the diff) — terse, actionable, no edits
agent: caveman-reviewer
---

Load the caveman-review skill rules.

Audit the entire repository for over-engineering, not just uncommitted changes. Hunt for: reinvented standard library, dependencies doing what the platform already covers, speculative abstractions (interface with one impl, factory for one product, config nobody sets), dead flexibility, and code that shrinks to fewer lines.

Use the over-engineering tags only (`🗑️ delete:` `📦 stdlib:` `🌐 native:` `✂️ yagni:` `📉 shrink:`). One line per finding: location, what to cut, what replaces it. Prioritize the biggest wins first.

End with `net: -<N> lines possible.` across the repo, or `Lean already. Ship.` if there's nothing worth cutting. Don't write fixes, don't approve. Output a delete-list ready to act on.

Scope hint: `$ARGUMENTS` (e.g. a subdirectory to focus on). If empty, scan the whole repo.
