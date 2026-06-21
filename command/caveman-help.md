---
description: Quick-reference card for all caveman modes, axes, skills, and commands
---

Display this reference card. One-shot — do NOT change mode or persist anything. Output in caveman style, in the user's language.

## Axes

Caveman minimize 3 things at once:

- **Output prose** — how you talk. ~60–75% fewer reply tokens.
- **Code** — what you build. YAGNI ladder: write only what task needs.
- **Input memory** — `/caveman-shrink` rewrites memory files on disk to cut tokens every session pays.

Safety never cut: validation, error handling, security, accessibility.

## Modes (`/caveman <level>`)

| Level | Prose | Code |
|-------|-------|------|
| `lite` | Drop filler. Keep full sentences. | Build asked, name lazier option. |
| `full` | Drop articles/filler/hedging. Fragments OK. Default. | Ladder enforced. Stdlib + native first. |
| `ultra` | Telegraphic. Abbreviations, arrows, one word. | YAGNI extremist. Delete before add. |
| `off` | Normal prose. | Normal building. |

Level stick until changed or session end.

## The ladder (code)

1. Need to exist? → no: skip (YAGNI)
2. Stdlib does it? → use it
3. Native platform? → use it
4. Installed dep? → use it
5. One line? → one line
6. Only then: minimum that works

Mark shortcuts: `# caveman: <ceiling>, <upgrade path>`

## Commands

| Command | What it do |
|---------|-----------|
| `/caveman <level>` | Toggle intensity (prose + code). |
| `/caveman-commit` | Terse Conventional Commits from staged diff. |
| `/caveman-review` | One-line review: bugs + over-engineering. |
| `/caveman-audit` | Scan whole repo for over-engineering. |
| `/caveman-debt` | Harvest deferred `caveman:` shortcuts into a ledger. |
| `/caveman-shrink <file>` | Compress a memory file on disk. Saves input tokens. |
| `/caveman-help` | This card. |

## Agents

- `caveman` — primary coding agent, terse prose + lazy code. Start: `opencode --agent caveman`.
- `caveman-reviewer` — read-only subagent. Reviews diffs (bugs + over-engineering), never edits.

## Off

Say "stop caveman" or "normal mode". Resume with `/caveman`.
