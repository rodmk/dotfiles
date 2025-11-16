#!/bin/bash

# Setup gitconfig personal include
setup_gitconfig() {
    local GITCONFIG="$HOME/.gitconfig"
    local GITCONFIG_PERSONAL="$HOME/.gitconfig_personal"

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
}

# Setup shell rc files
setup_rc_file() {
    local rc_file="$HOME/$1"
    local source_line='[ -f ~/.shellrc ] && . ~/.shellrc'

    touch "$rc_file"

    if ! grep -q ".shellrc" "$rc_file"; then
        if [ -s "$rc_file" ] && [ -n "$(tail -n 1 "$rc_file")" ]; then
            echo "" >> "$rc_file"
        fi
        echo "# Source shared shell configuration" >> "$rc_file"
        echo "$source_line" >> "$rc_file"
        echo "Added shellrc source line to $rc_file"
    fi
}

# Run all setup tasks
setup_gitconfig
setup_rc_file ".bashrc"
setup_rc_file ".zshrc"
setup_rc_file ".profile"
