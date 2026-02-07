#!/bin/bash
set -e

make install-packages

# Persist Claude data across Codespaces container rebuilds
if [ "$CODESPACES" = "true" ]; then
    mkdir -p /workspaces/.claude
    ln -sfn /workspaces/.claude ~/.claude
fi
