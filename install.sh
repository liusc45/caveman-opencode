#!/usr/bin/env bash
# Installs the caveman skill, agent and command into your opencode config.
set -euo pipefail

CONFIG_DIR="${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$CONFIG_DIR/skills" "$CONFIG_DIR/agent" "$CONFIG_DIR/command"

cp -R "$REPO_DIR/skills/caveman-compress" "$CONFIG_DIR/skills/"
cp "$REPO_DIR/agent/caveman.md" "$CONFIG_DIR/agent/"
cp "$REPO_DIR/command/caveman.md" "$CONFIG_DIR/command/"

echo "caveman installed in $CONFIG_DIR"
echo ""
echo "  opencode --agent caveman   # start with caveman agent"
echo "  /caveman lite|full|ultra   # change intensity in any session"
echo "  /caveman off               # back to normal"
