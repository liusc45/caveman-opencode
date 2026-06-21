#!/usr/bin/env bash
# Installs the caveman skills, agents and commands into your opencode config.
set -euo pipefail

CONFIG_DIR="${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$CONFIG_DIR/skills" "$CONFIG_DIR/agent" "$CONFIG_DIR/command"

# Skills (sync into a fresh dir so re-installs don't nest folders)
for skill in caveman-compress caveman-commit caveman-review caveman-debt caveman-shrink caveman-memory; do
  rm -rf "$CONFIG_DIR/skills/$skill"
  cp -R "$REPO_DIR/skills/$skill" "$CONFIG_DIR/skills/$skill"
done

# Agents (primary + subagent)
cp "$REPO_DIR/agent/caveman.md"          "$CONFIG_DIR/agent/"
cp "$REPO_DIR/agent/caveman-reviewer.md" "$CONFIG_DIR/agent/"

# Commands
cp "$REPO_DIR/command/caveman.md"         "$CONFIG_DIR/command/"
cp "$REPO_DIR/command/caveman-commit.md"  "$CONFIG_DIR/command/"
cp "$REPO_DIR/command/caveman-review.md"  "$CONFIG_DIR/command/"
cp "$REPO_DIR/command/caveman-audit.md"   "$CONFIG_DIR/command/"
cp "$REPO_DIR/command/caveman-debt.md"    "$CONFIG_DIR/command/"
cp "$REPO_DIR/command/caveman-shrink.md"  "$CONFIG_DIR/command/"
cp "$REPO_DIR/command/caveman-memory.md"  "$CONFIG_DIR/command/"
cp "$REPO_DIR/command/caveman-help.md"    "$CONFIG_DIR/command/"

echo "caveman installed in $CONFIG_DIR"
echo ""
echo "  opencode --agent caveman            # start with caveman agent (terse prose + lazy code)"
echo "  /caveman lite|full|ultra            # change intensity (prose + code) in any session"
echo "  /caveman off                        # back to normal"
echo "  /caveman-commit                     # generate a commit message"
echo "  /caveman-review                     # review the current diff (bugs + over-engineering)"
echo "  /caveman-audit                      # audit the whole repo for over-engineering"
echo "  /caveman-debt                       # harvest deferred caveman: shortcuts into a ledger"
echo "  /caveman-shrink <file>              # compress a memory file (saves input tokens)"
echo "  /caveman-memory save|recall|forget  # persistent project memory in your Obsidian vault"
echo "  /caveman-help                       # quick reference card"

command -v opencode >/dev/null 2>&1 || echo "
note: 'opencode' not found on PATH. Install it from https://opencode.ai"
