---
name: caveman-memory
description: Persistent project memory stored as markdown notes in an Obsidian vault. The agent saves decisions, gotchas, file locations, commands, and learnings across sessions, and recalls them at the start of new work. Entries are written in caveman-speak to save tokens on recall. Use when the user says "remember this", "save to memory", "what do you remember about X", "recall", "recuerda esto", "qué sabes de este proyecto", or invokes /caveman-memory.
metadata:
  origin: opencode
  effort: low
---

# Caveman Memory

Persistent memory in an Obsidian vault. Survives across sessions. Terse entries (caveman-speak) so recall is cheap. Selective by design — signal over noise.

## Vault location

Resolve the vault root in this order:
1. `$CAVEMAN_VAULT` env var if set
2. `~/Documents/Obsidian Vault`

Memory lives under `<vault>/caveman-memory/`:

```
caveman-memory/
  index.md                      # all project notes + one-line summary + last-touched
  projects/<slug>.md            # one note per project (default)
  projects/<slug>/<topic>.md    # split notes when project grows (see Atomicity)
  concepts/<topic>.md           # cross-project knowledge (patterns, idioms)
  archive/                      # pruned/stale notes moved here
```

`<slug>` = current repo/dir name, lowercased, spaces→`-`. Derive from `git rev-parse --show-toplevel` basename, else cwd basename.

## What to save — the stress test

Before saving anything, run this test:

> **If I deleted this note, how many steps would a future session need to rebuild it?**

| Steps to rebuild | Verdict | Action |
|---|---|---|
| 0–1 (trivia, googleable, already in code/README) | Noise | **Don't save** |
| 2 (useful but recoverable in <10 min) | Maybe | Save only if it recurs 2+ times. Tag `#maybe` |
| 3+ (hard-won, multi-step, would cost >30 min) | Signal | **Always save** |

**Never save:** typo fixes already applied, ephemeral debug values, anything in `README.md` or code comments, planning chatter that produced no change, facts googleable in <30 seconds.

## Session-aware saving

What's worth saving depends on what you're doing:

| Session type | Save this | Don't save just the... |
|---|---|---|
| **debug** | symptom + root cause + fix | ...fix alone (cause is the signal) |
| **feature** | design decision + alternatives dropped + why | ...code diff (it's in git) |
| **onboarding** | architecture map + entry points + where to start reading | ...obvious structure (folders are self-evident) |
| **refactor** | old pattern → new pattern + rollback risk | ...mechanical changes |
| **config/deploy** | working command + env requirements + what breaks without it | ...one-time values |

## Categories

Pick the section by intent. More granular than before to improve recall precision:

| Section | Intent | Example |
|---|---|---|
| **Decisions** | design choice + rationale + alternatives dropped | "Bun over npm — 2× install speed, lockfile simpler" |
| **Gotchas** | footgun: symptom → cause → fix | "Build fails on CI: Node 18 vs 20, `engines` field needed" |
| **Procedures** | repeatable how-to sequence (>1 step) | "Deploy: `vp build` → `wrangler deploy` → verify `/_health`" |
| **Checks** | pre-merge / pre-deploy validation points | "Before merge: `oxlint`, `vitest run`, `wrangler dry-run`" |
| **Key files** | where non-obvious things live | "Auth middleware: `src/middleware/auth.ts:42`" |
| **Commands** | working one-liner + when to use it | "`vp migrate --no-interactive` — use when upgrading Vite+" |
| **Open questions** | unresolved item to revisit | "SSR plugins with Rolldown — validate before 1.0" |

## Tags: confidence & volatility

Every bullet ends with tags. Two axes:

**Confidence** (how sure are we?):
- `#confirmed` — tested, verified working
- `#probable` — seems right, not fully verified
- `#draft` — incomplete, needs validation next session

**Volatility** (how long until this rots?):
- `#stable` — valid >1 year (architecture, patterns)
- `#volatile` — may break on next version bump (API shape, config syntax)
- `#decay:YYYY-MM` — explicit review date (e.g. `#decay:2026-09` = review by Sep 2026)

Omit `#stable` if obvious (default). Always tag `#volatile` or `#decay` when the fact depends on a specific version.

## Note template (on creation)

```markdown
---
project: <slug>
created: <YYYY-MM-DD>
last_touched: <YYYY-MM-DD>
tags: [caveman-memory]
---

# <slug>

## Decisions

## Gotchas

## Procedures

## Checks

## Key files

## Commands

## Open questions
```

## Append format

Caveman-speak, dated, tagged. Link to code when possible.

```markdown
- 2026-06-20: Auth JWT expiry off-by-one (`<` vs `<=`). Fix: `src/auth/token.ts:38`. ↔ `caveman:` at token.ts:35 #confirmed #volatile
```

The `↔` marker creates a bidirectional link: the code has a `caveman:` comment, and this note points back to it. See **Cross-linking** below.

## Actions

### save / remember

When the user says "remember X" or you learn something worth persisting:

1. Run the **stress test**. If it doesn't pass (0–1 steps) → don't save, say why in one line.
2. Ensure `caveman-memory/projects/` exists (`mkdir -p`).
3. Open (or create) `projects/<slug>.md`. If new, write the header template above.
4. Pick the **category** by intent (table above).
5. Append a dated caveman bullet with **confidence + volatility** tags.
6. If the gotcha has a `caveman:` comment in code, add `↔ code: path:line`.
7. Update `last_touched` in frontmatter.
8. Refresh `index.md`: project line + last-touched date.
9. Confirm in one caveman line: `mem → <slug>.md`.

### recall / load

**When to read memory:**
- Starting a non-trivial task in a project (debugging, architecture change, touching unfamiliar area)
- User asks "what do you remember about X"
- You're stuck for >10 min on something that might be a known gotcha

**When NOT to read memory** (avoid anchoring bias):
- Trivial task (typo, formatting, rename)
- User says "start fresh" / "ignore memory"
- Task is purely mechanical (bump version, update dependency)
- You already read it this session and the task hasn't changed scope

**How to recall:**
1. Read `projects/<slug>.md` if it exists.
2. Surface only what's relevant to the current task — max 3 caveman bullets. Filter by category relevance.
3. Check `#volatile` and `#decay` tags — flag any that might be stale: "⚠️ `#decay:2026-03` — may be outdated".
4. If no note: say nothing, proceed. (Don't announce "no memory found".)

### forget

Remove the specific bullet from `projects/<slug>.md`. Never delete the whole file or unrelated notes. Confirm what was removed.

### prune

Periodic maintenance (trigger when `last_touched` > 6 months old, or when opening a project with `#decay` tags past their date):

1. Scan all bullets with `#volatile`, `#decay`, or `#draft` tags.
2. For each: is it still true? If yes → upgrade to `#confirmed` or remove decay tag. If no → move to `archive/<slug>.md` with a note on why it's stale.
3. If project note >150 lines → consider splitting (see Atomicity).
4. Update `last_touched` in frontmatter.

## Cross-linking with code

Memory and code comments are two views of the same knowledge. Link them:

**Code → Memory:** When writing a `caveman:` shortcut comment in code that relates to a known gotcha:
```typescript
// caveman: simplified retry — no backoff yet. ↔ mem: gotchas (retry-storm risk)
```

**Memory → Code:** When saving a gotcha that has a `caveman:` comment:
```markdown
- 2026-06-20: Retry storms under load. Simplified retry has no backoff. ↔ `caveman:` at api/client.ts:87 #confirmed #volatile
```

Don't duplicate — the code comment holds the shortcut detail, the memory note holds the context + history.

## Note atomicity

Default: **one note per project** (`projects/<slug>.md`). This works for most projects.

**Split into sub-notes** when ANY of these trigger:
- Project note exceeds **150 lines**
- A single category (e.g. Gotchas) has **>10 bullets**
- The project has **distinct subsystems** worth independent recall (e.g. frontend vs backend)

**Split structure:**
```
projects/<slug>.md              # index: links to sub-notes + top-3 critical facts
projects/<slug>/gotchas.md      # split by subsystem
projects/<slug>/decisions.md
projects/<slug>/deploy.md       # procedures + checks grouped
```

The main `<slug>.md` stays as an index with `[[wikilinks]]` to sub-notes and retains the 3 most critical bullets inline.

**Cross-project knowledge** (patterns, idioms, tool configs that apply everywhere) → `concepts/<topic>.md`. Link from project notes with `[[concepts/topic]]`.

## Rules

- Write ONLY inside `<vault>/caveman-memory/`. Never touch other vault notes.
- Memory entries are caveman-speak; code blocks, paths, commands stay exact (backticks).
- Append, don't rewrite — preserve history. Dedupe only exact-duplicate bullets.
- Every bullet needs confidence + volatility tags (omit `#stable` if obvious).
- Use Obsidian-flavored markdown: `[[wikilinks]]` between notes, `#tags` for filtering.
- Don't auto-save trivia. Run the stress test first.
- File writes only — no git, no deletes beyond explicit "forget".
- When recalling: filter by relevance, never dump the whole file. Max 3 bullets surfaced.
- When pruning: move stale to `archive/`, don't delete.
