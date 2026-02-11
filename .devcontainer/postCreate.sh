#!/bin/bash
set -e

# Persist Claude data across Codespaces container rebuilds
if [ "$CODESPACES" = "true" ]; then
    mkdir -p /workspaces/.claude
    ln -sfn /workspaces/.claude ~/.claude

    # Fetch SSH key from 1Password
    if [ ! -f ~/.ssh/id_ed25519 ] && command -v op >/dev/null 2>&1; then
        mkdir -p ~/.ssh && chmod 700 ~/.ssh
        op read "op://Development/GitHub SSH Key/private key" > ~/.ssh/id_ed25519
        chmod 600 ~/.ssh/id_ed25519
    fi
fi

make hooks
