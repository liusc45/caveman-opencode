---
description: Generate a caveman Conventional Commits message from staged changes
agent: caveman
---

Load the caveman-commit skill rules.

Staged diff:
!`git diff --cached --stat`
!`git diff --cached`

Write one Conventional Commits message for these staged changes. Subject ≤50 chars, imperative mood. Add a body only if the "why" isn't obvious or there's a breaking change. Output the message as a code block ready to paste. Do not run git commit.

Extra instructions: $ARGUMENTS
