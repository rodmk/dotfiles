#!/bin/bash
set -e

# Persist Claude config across container rebuilds (Codespaces only)
if [ "$CODESPACES" = "true" ]; then
    mkdir -p /workspaces/.claude
    ln -sfn /workspaces/.claude ~/.claude
fi

# Install Claude
curl -fsSL https://claude.ai/install.sh | bash
