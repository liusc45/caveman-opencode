#!/usr/bin/env bash
# Installs the caveman skills, agents and commands into your opencode config.
set -euo pipefail

CONFIG_DIR="${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$CONFIG_DIR/skills" "$CONFIG_DIR/agent" "$CONFIG_DIR/command"

# Skills
cp -R "$REPO_DIR/skills/caveman-compress" "$CONFIG_DIR/skills/"
cp -R "$REPO_DIR/skills/caveman-commit"  "$CONFIG_DIR/skills/"
cp -R "$REPO_DIR/skills/caveman-review"  "$CONFIG_DIR/skills/"
cp -R "$REPO_DIR/skills/caveman-debt"    "$CONFIG_DIR/skills/"

# Agents (primary + subagent)
cp "$REPO_DIR/agent/caveman.md"          "$CONFIG_DIR/agent/"
cp "$REPO_DIR/agent/caveman-reviewer.md"  "$CONFIG_DIR/agent/"

# Commands
cp "$REPO_DIR/command/caveman.md"         "$CONFIG_DIR/command/"
cp "$REPO_DIR/command/caveman-commit.md"  "$CONFIG_DIR/command/"
cp "$REPO_DIR/command/caveman-review.md"  "$CONFIG_DIR/command/"
cp "$REPO_DIR/command/caveman-audit.md"   "$CONFIG_DIR/command/"
cp "$REPO_DIR/command/caveman-debt.md"    "$CONFIG_DIR/command/"

echo "caveman installed in $CONFIG_DIR"
echo ""
echo "  opencode --agent caveman            # start with caveman agent"
echo "  /caveman lite|full|ultra            # change intensity (prose + code) in any session"
echo "  /caveman off                        # back to normal"
echo "  /caveman-commit                     # generate a commit message"
echo "  /caveman-review                     # review the current diff (bugs + over-engineering)"
echo "  /caveman-audit                      # audit the whole repo for over-engineering"
echo "  /caveman-debt                       # harvest deferred caveman: shortcuts into a ledger"
