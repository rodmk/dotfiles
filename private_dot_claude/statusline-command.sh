#!/bin/sh
# Claude Code statusline — reuses the shell prompt and appends model/context.
# No external dependencies — uses POSIX shell parameter expansion for JSON.

# shellcheck source=/dev/null
. "$HOME/.local/lib/prompt-helpers.sh"

input=$(cat)

# Extract a JSON string value by key: "key":"value"
_json_str() { _t="${input#*\"$1\":\"}"; [ "$_t" != "$input" ] && printf '%s' "${_t%%\"*}"; }
# Extract a JSON number value by key: "key":number
_json_num() { _t="${input#*\"$1\":}"; [ "$_t" != "$input" ] && _n="${_t%%[,\}]*}" && printf '%s' "$_n"; }

cwd=$(_json_str current_dir)
model=$(_json_str display_name)
used=$(_json_num used_percentage)

case "$cwd" in "$HOME"*) dir="~${cwd#"$HOME"}" ;; *) dir="$cwd" ;; esac

output=$(build_base_prompt "$dir" "$cwd")
output="${output} |"
[ -n "$model" ] && output="${output} $(printf "\033[2m%s\033[0m" "$model")"
[ -n "$used" ] && output="${output} $(printf "\033[2mctx:%.0f%%\033[0m" "$used")"
printf "%s" "$output"
