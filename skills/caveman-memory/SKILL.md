---
name: caveman-memory
description: Persistent project memory stored as markdown notes in an Obsidian vault. The agent saves decisions, gotchas, file locations, commands, and learnings across sessions, and recalls them at the start of new work. Entries are written in caveman-speak to save tokens on recall. Use when the user says "remember this", "save to memory", "what do you remember about X", "recall", "recuerda esto", "qué sabes de este proyecto", or invokes /caveman-memory.
metadata:
  origin: opencode
  effort: low
---

# Caveman Memory

Persistent memory in an Obsidian vault. Survives across sessions. One note per project. Entries terse (caveman-speak) so recall is cheap.

## Vault location

Resolve the vault root in this order:
1. `$CAVEMAN_VAULT` env var if set
2. `~/Documents/Obsidian Vault`

Memory lives under `<vault>/caveman-memory/`:

```
caveman-memory/
  index.md                    # list of all project notes + one-line summary
  projects/<slug>.md          # one note per project
```

`<slug>` = current repo/dir name, lowercased, spaces→`-`. Derive from `git rev-parse --show-toplevel` basename, else the cwd basename.

## Actions

### save / remember

When the user says "remember X" or you learn something worth persisting:

1. Ensure `caveman-memory/projects/` exists (`mkdir -p`).
2. Open (or create) `projects/<slug>.md`. If new, write the header template below.
3. Append a dated bullet under the right section, in caveman-speak.
4. Update `index.md`: add/refresh the project line.
5. Confirm in one caveman line: `Saved → <slug>.md`.

Note header template (only when creating the file):

```markdown
---
project: <slug>
created: <YYYY-MM-DD>
tags: [caveman-memory]
---

# <slug>

## Decisions

## Gotchas

## Key files

## Commands

## Open questions
```

Append format (caveman-speak, dated):

```markdown
- 2026-06-20: Auth uses JWT in `src/auth/token.ts`. Expiry check `<` not `<=` — off-by-one fixed.
```

Pick the section by intent: design choice → Decisions, footgun → Gotchas, where-things-live → Key files, repeatable cmd → Commands, unresolved → Open questions.

### recall / load

At the start of work on a project, or when asked "what do you remember about X":

1. Read `projects/<slug>.md` if it exists.
2. Summarize relevant sections in caveman-speak. Don't dump the whole file — surface what's relevant to the current task.
3. If no note exists, say so in one line: `No memory for <slug> yet.`

### forget

When asked to forget something: remove the specific bullet (or section) from `projects/<slug>.md`. Never delete the whole vault or unrelated notes. Confirm what was removed.

## Rules

- Write ONLY inside `<vault>/caveman-memory/`. Never touch other vault notes.
- Memory entries are caveman-speak; code blocks, paths, commands stay exact (backticks).
- Append, don't rewrite — preserve history. Dedupe only exact-duplicate bullets.
- Use Obsidian-flavored markdown: `[[wikilinks]]` between project notes are fine; `#tags` allowed.
- Don't auto-save trivia. Save decisions, gotchas, hard-won facts — things a future session would waste time rediscovering.
- Don't run destructive git/fs commands. File writes only.
