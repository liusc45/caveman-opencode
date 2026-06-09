# caveman-opencode 🪨

Caveman mode for [opencode](https://opencode.ai): same technical quality, **~75% fewer output tokens**. Smart caveman speak prose, code stay normal.

Ported from the `caveman-compress` skill in [JuliusBrussee/caveman-code](https://github.com/JuliusBrussee/caveman-code).

> **User:** Why is my React component re-rendering?
>
> **Caveman:** New object ref each render. Inline object prop = new ref = re-render. Wrap in `useMemo`.

## What you get

| Piece | Path | What it does |
|-------|------|--------------|
| Skill | `skills/caveman-compress/SKILL.md` | Compression rules with 3 intensities (lite / full / ultra) |
| Agent | `agent/caveman.md` | Primary agent that always answers in caveman mode |
| Command | `command/caveman.md` | `/caveman lite\|full\|ultra\|off` toggle in any session |

## Install

One-liner:

```bash
git clone https://github.com/liusc45/-caveman-opencode.git /tmp/caveman-opencode && bash /tmp/caveman-opencode/install.sh
```

Or manually copy into your opencode config (`~/.config/opencode` by default):

```bash
cp -R skills/caveman-compress ~/.config/opencode/skills/
cp agent/caveman.md ~/.config/opencode/agent/
cp command/caveman.md ~/.config/opencode/command/
```

Skill only (via the [skills](https://github.com/vercel-labs/skills) CLI):

```bash
npx skills add liusc45/-caveman-opencode
```

## Use

```bash
opencode --agent caveman        # start session with caveman agent
```

Inside any opencode session:

```
/caveman ultra    # maximum grunt
/caveman lite     # professional, no fluff
/caveman off      # normal mode
```

Or press **Tab** in the TUI to cycle to the `caveman` agent.

## Intensities

- **lite** — professional tone, no filler or hedging, full grammar
- **full** (default) — drop articles, fragments fine, technical terms exact
- **ultra** — telegraphic: abbreviations, arrow notation, one word when one word enough

## Boundaries

Caveman applies to prose only. Code, git commits, PR descriptions and file contents stay normal. Error messages quoted exact.

## Credits

Compression rules from [caveman-code](https://github.com/JuliusBrussee/caveman-code) by Julius Brussee (MIT). This repo packages them in opencode-native format.
