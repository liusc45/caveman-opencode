---
description: Save to or recall from caveman's persistent Obsidian memory (save | recall | forget | prune)
agent: caveman
---

Load the caveman-memory skill rules. Vault: `$CAVEMAN_VAULT` or `~/Documents/Obsidian Vault`. Notes under `caveman-memory/projects/<slug>.md` where `<slug>` is the current repo/dir basename.

Parse `$ARGUMENTS`:
- `save <text>` / `remember <text>` → run stress test (steps to rebuild? 0–1 skip, 2 if recurring, 3+ save). If pass: append dated caveman bullet with confidence + volatility tags to the right category (Decisions / Gotchas / Procedures / Checks / Key files / Commands / Open questions). Cross-link `↔ caveman:` code comments if present. Confirm `mem → <slug>.md`.
- `recall` (or empty) → read project note, surface ≤3 relevant caveman bullets. Flag stale `#volatile`/`#decay` tags. No note → `No memory for <slug> yet.`
- `forget <text>` → remove matching bullet only. Confirm what was removed.
- `prune` → verify `#volatile`/`#draft`/`#decay` bullets. Upgrade confirmed ones, move stale to `archive/<slug>.md`. Update `last_touched`.

Categories: Decisions (design+why), Gotchas (symptom→cause→fix), Procedures (how-to), Checks (pre-merge/deploy), Key files (where), Commands (one-liners), Open questions (unresolved).

Tags: confidence `#confirmed`/`#probable`/`#draft`. Volatility `#stable`/`#volatile`/`#decay:YYYY-MM`.

Write only inside `caveman-memory/`. No git. No deletes beyond explicit forget.
