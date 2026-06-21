---
description: Compress a memory file (CLAUDE.md, AGENTS.md, notes) into caveman prose to save input tokens
agent: caveman
---

Load the caveman-shrink skill rules.

Compress the file at `$ARGUMENTS` in place. First read it, save an unmodified backup as `<name>.original.<ext>`, then rewrite only the prose — keep all code blocks, inline code, URLs, paths, commands, frontmatter and structure exactly. Report original vs compressed size and % saved. Don't run git.

If `$ARGUMENTS` is empty, ask which file to shrink.

To undo later: `mv <name>.original.<ext> <name>.<ext>` restores the untouched original.
