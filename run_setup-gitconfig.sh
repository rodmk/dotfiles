#!/bin/bash

GITCONFIG="$HOME/.gitconfig"
GITCONFIG_PERSONAL="$HOME/.gitconfig_personal"

touch "$GITCONFIG"

if ! grep -q "gitconfig_personal" "$GITCONFIG"; then
    # Create a temporary file with the include at the top
    {
        echo "[include]"
        echo "	path = $GITCONFIG_PERSONAL"
        echo ""
        cat "$GITCONFIG"
    } > "$GITCONFIG.tmp"

    mv "$GITCONFIG.tmp" "$GITCONFIG"
    echo "Added gitconfig_personal include at the top of .gitconfig"
fi
