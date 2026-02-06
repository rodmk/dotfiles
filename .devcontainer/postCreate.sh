#!/bin/bash
set -e

sudo apt-get update && sudo apt-get install -y shellcheck tmux

# Persist Claude data across Codespaces container rebuilds
if [ "$CODESPACES" = "true" ]; then
    mkdir -p /workspaces/.claude
    ln -sfn /workspaces/.claude ~/.claude
fi

# Install Claude
if ! command -v claude &> /dev/null; then
    curl -fsSL https://claude.ai/install.sh | bash
fi
