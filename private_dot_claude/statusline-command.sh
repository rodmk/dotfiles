#!/bin/sh
# Claude Code statusline — reuses the shell prompt and appends model/context.

# shellcheck source=/dev/null
. "$HOME/.local/lib/prompt-helpers.sh"

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // ""')
model=$(echo "$input" | jq -r '.model.display_name // ""')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

case "$cwd" in "$HOME"*) dir="~${cwd#"$HOME"}" ;; *) dir="$cwd" ;; esac

output=$(build_base_prompt "$dir" "$cwd")
output="${output} |"
[ -n "$model" ] && output="${output} $(printf "\033[2m%s\033[0m" "$model")"
[ -n "$used" ] && output="${output} $(printf "\033[2mctx:%.0f%%\033[0m" "$used")"
printf "%s" "$output"
