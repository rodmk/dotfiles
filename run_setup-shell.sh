#!/bin/bash

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

setup_rc_file ".bashrc"
setup_rc_file ".zshrc"
setup_rc_file ".profile"
