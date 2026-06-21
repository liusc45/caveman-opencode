# caveman-opencode 🪨

Three-axis minimalism for [opencode](https://opencode.ai). Caveman compresses on three fronts at once:

1. **Output prose** — how you talk. ~25% (lite) to ~80% (ultra) fewer output tokens, ~62% at the default `full`. Smart caveman speak; code stays normal.
2. **Code** — what you build. A 6-rung YAGNI ladder so the agent writes only what the task needs. Less code, fewer deps, shortest working diff.
3. **Input memory** — `/caveman-shrink` rewrites memory files (CLAUDE.md, AGENTS.md, notes) on disk so every future session loads fewer tokens.

Same technical rigor. Safety guards (validation, error handling, security, accessibility) are **never** on the chopping block.

Prose rules ported from the `caveman-compress` skill in [JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman). Code axis (YAGNI ladder) inspired by [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail) — *"ponytail governs what you build, not how you talk; pair with caveman for terse prose."* This repo pairs both, plus input-side shrinking.

> **User:** Why is my React component re-rendering?
>
> **Caveman:** New object ref each render. Inline object prop = new ref = re-render. Wrap in `useMemo`.

> **User:** Add a date picker.
>
> **Caveman:** `<input type="date">` → skipped: picker lib, add when you need range/locale control.

## The axes

### Output prose (how you talk)

| Level | What changes |
|-------|--------------|
| **lite** | Professional tone, no filler or hedging, full grammar. ~25% reduction |
| **full** (default) | Drop articles, fragments fine, technical terms exact. ~60–65% reduction |
| **ultra** | Telegraphic: abbreviations, arrow notation, one word when one word is enough. ~80% reduction |

### Code (what you build)

Before writing code, stop at the first rung that holds:

```
1. Does this need to exist at all?   → no: skip it (YAGNI)
2. Stdlib does it?                   → use it
3. Native platform feature?          → use it (<input type="date">, CSS over JS)
4. Already-installed dependency?     → use it, never add a new one for a few lines
5. One line?                         → one line
6. Only then:                        → the minimum that works
```

`lite` names the lazier alternative and lets you pick. `full` enforces the ladder. `ultra` is YAGNI-extremist. Deliberate simplifications get a `caveman:` comment naming the ceiling and upgrade path:

```python
# caveman: global lock, per-account locks if throughput matters
```

### Input memory (what loads every session)

`/caveman-shrink <file>` compresses a prose memory file in place (after a backup), keeping all code, URLs, paths, commands and structure exact. Cuts the input tokens every future session pays.

## What you get

| Piece | Path | What it does |
|-------|------|--------------|
| Skill | `skills/caveman-compress/SKILL.md` | Two-axis rules (prose + YAGNI ladder), 3 intensities |
| Skill | `skills/caveman-commit/SKILL.md` | Terse Conventional Commits generator |
| Skill | `skills/caveman-review/SKILL.md` | Terse review: bugs **and** over-engineering |
| Skill | `skills/caveman-debt/SKILL.md` | Harvest deferred `caveman:` shortcuts into a ledger |
| Skill | `skills/caveman-shrink/SKILL.md` | Compress memory files on disk to save **input** tokens |
| Agent | `agent/caveman.md` | Primary agent — minimizes prose + code every turn |
| Agent | `agent/caveman-reviewer.md` | Read-only reviewer (bugs + over-engineering), no edits |
| Command | `command/caveman.md` | `/caveman lite\|full\|ultra\|off` toggle |
| Command | `command/caveman-commit.md` | `/caveman-commit` from staged changes |
| Command | `command/caveman-review.md` | `/caveman-review` the current diff |
| Command | `command/caveman-audit.md` | `/caveman-audit` the whole repo for over-engineering |
| Command | `command/caveman-debt.md` | `/caveman-debt` harvest deferred shortcuts |
| Command | `command/caveman-shrink.md` | `/caveman-shrink <file>` shrink a memory file |
| Command | `command/caveman-help.md` | `/caveman-help` quick reference card |

## Install

One-liner:

```bash
git clone https://github.com/liusc45/caveman-opencode.git /tmp/caveman-opencode && bash /tmp/caveman-opencode/install.sh
```

The installer is idempotent — re-running it overwrites cleanly, no nested folders.

Or manually copy into your opencode config (`~/.config/opencode` by default):

```bash
cp -R skills/caveman-* ~/.config/opencode/skills/
cp agent/caveman*.md   ~/.config/opencode/agent/
cp command/caveman*.md ~/.config/opencode/command/
```

Skill only (via the [skills](https://github.com/vercel-labs/skills) CLI):

```bash
npx skills add liusc45/caveman-opencode
```

## Use

```bash
opencode --agent caveman        # start session with caveman agent
```

Inside any opencode session:

```
/caveman ultra            # maximum grunt + YAGNI extremist
/caveman lite             # professional, no fluff, names lazier option
/caveman off              # normal mode (both axes)

/caveman-commit           # terse commit message from staged changes
/caveman-review           # review current diff: bugs + over-engineering
/caveman-audit            # audit whole repo for over-engineering
/caveman-debt             # harvest deferred caveman: shortcuts into a ledger
/caveman-shrink <file>    # compress a memory file on disk (saves input tokens)
/caveman-help             # quick reference card
```

Or press **Tab** in the TUI to cycle to the `caveman` agent.

## Boundaries

- Prose is compressed; **code formatting/syntax stays normal** (only the diff size shrinks).
- Git commits, PR descriptions and file contents stay normal prose. Error messages quoted exact.
- Explanation you explicitly ask for (a report, a walkthrough) is given in full — the rule only bans *unrequested* prose.
- "stop caveman" / "normal mode" reverts both axes immediately.
- Never simplifies away: input validation at trust boundaries, error handling that prevents data loss, security, accessibility, anything explicitly requested.

## Credits

- Prose compression rules from [caveman](https://github.com/JuliusBrussee/caveman) by Julius Brussee (MIT).
- YAGNI ladder (code axis) inspired by [ponytail](https://github.com/DietrichGebert/ponytail) by Dietrich Gebert (MIT).

This repo packages them into opencode-native format.
