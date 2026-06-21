---
name: caveman-shrink
description: Compress a natural-language memory file (CLAUDE.md, AGENTS.md, todos, notes) into caveman prose to save INPUT tokens on every future session. Preserves all code, URLs, paths, commands, and structure exactly. Overwrites the file in place after saving a backup. Use when the user says "/caveman-shrink <file>", "compress this memory file", "shrink my CLAUDE.md", "comprime este archivo", or invokes /caveman-shrink.
metadata:
  origin: opencode
  effort: low
---

# Caveman Shrink

Compress natural-language files into caveman-speak to cut **input** tokens. Unlike caveman-compress (which compresses your live replies), this rewrites a file on disk so every future session loads fewer tokens.

## Process

1. Read the target file.
2. If the file is not prose (see Boundaries), stop and tell the user — don't touch it.
3. Save an unmodified backup next to it as `<name>.original.<ext>` (skip if a backup already exists; never overwrite a backup).
4. Apply the compression rules below.
5. Write the compressed version back to the original path.
6. Report: original vs compressed char count and rough % saved.

## Remove

- Articles: a, an, the (and ES: el, la, los, las, un, una)
- Filler: just, really, basically, actually, simply, essentially
- Pleasantries: "sure", "of course", "happy to", "I'd recommend"
- Hedging: "it might be worth", "you could consider", "it would be good to"
- Redundant phrasing: "in order to" → "to", "make sure to" → "ensure", "utilize" → "use"
- Connective fluff: "however", "furthermore", "additionally"

## Preserve EXACTLY (never modify)

- Fenced code blocks (``` ... ```) and indented code — read-only regions
- Inline code (`backtick content`)
- URLs, markdown links, file paths
- Commands (`npm install`, `git commit`)
- Technical terms, proper nouns, library/API names
- Dates, version numbers, numeric values, env vars (`$HOME`, `NODE_ENV`)
- YAML frontmatter
- Heading text, list nesting, numbering, table structure

Compress only the prose *outside* these regions.

## Pattern

Original:
> You should always make sure to run the test suite before pushing any changes to the main branch. This is important because it catches bugs early.

Compressed:
> Run tests before push to main. Catch bugs early.

## Boundaries

- ONLY compress prose files: `.md`, `.txt`, `.mdc`, extensionless memory files
- NEVER modify: `.py`, `.js`, `.ts`, `.json`, `.yaml`, `.yml`, `.toml`, `.env`, `.lock`, `.css`, `.html`, `.sql`, `.sh`
- Mixed content (prose + code): compress prose only, leave all code untouched
- If unsure whether a line is code or prose, leave it unchanged
- Never compress a `*.original.*` backup
- Don't run git. Don't commit. Just write the file and report savings.
