---
description: Quick-reference card for all caveman modes, skills, and commands
---

Display this reference card. One-shot — do NOT change mode or persist anything. Output in caveman style, in the user's language.

## Modes (`/caveman <level>`)

| Level | What change |
|-------|-------------|
| `lite` | Drop filler. Keep full sentences. |
| `full` | Drop articles, filler, pleasantries, hedging. Fragments OK. Default. |
| `ultra` | Telegraphic. Abbreviations, arrow notation, one word when enough. |
| `off` | Back to normal prose. |

Level stick until changed or session end.

## Commands

| Command | What it do |
|---------|-----------|
| `/caveman <level>` | Toggle compression intensity. |
| `/caveman-commit` | Terse Conventional Commits from staged diff. |
| `/caveman-review` | One-line PR comments: `L42: bug: user null. Add guard.` |
| `/caveman-shrink <file>` | Compress a memory file on disk. Saves input tokens. |
| `/caveman-help` | This card. |

## Agents

- `caveman` — primary coding agent, always caveman prose. Start: `opencode --agent caveman`.
- `caveman-reviewer` — read-only subagent. Reviews diffs, never edits.

## Off

Say "stop caveman" or "normal mode". Resume with `/caveman`.
