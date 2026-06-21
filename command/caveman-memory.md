---
description: Save to or recall from caveman's persistent Obsidian memory (save | recall | forget)
agent: caveman
---

Load the caveman-memory skill rules. Vault: `$CAVEMAN_VAULT` or `~/Documents/Obsidian Vault`. Note: `caveman-memory/projects/<slug>.md` where `<slug>` is the current repo/dir basename.

Parse `$ARGUMENTS`:
- starts with `save ` or `remember ` → append the rest as a dated caveman bullet to the right section. Confirm `mem → <slug>.md`.
- starts with `recall` (or empty) → read the project note and summarize relevant parts in caveman bullets. No note → `No memory for <slug> yet.`
- starts with `forget ` → remove the matching bullet only. Confirm what was removed.

Write only inside `caveman-memory/`. No git. No deletes beyond an explicit forget.
