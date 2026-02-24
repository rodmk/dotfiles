# shellcheck shell=sh
# Shared prompt helpers — sourced by .shellrc and Claude statusline.

# Get the git branch/tag/SHA for a directory (defaults to cwd).
get_git_branch() {
    _dir="${1:-.}"
    git -C "$_dir" symbolic-ref --short HEAD 2>/dev/null ||
    git -C "$_dir" describe --tags --exact-match 2>/dev/null ||
    git -C "$_dir" rev-parse --short HEAD 2>/dev/null
}

# Detect environment name for prompt prefix.
# Priority: cloud workspace name > hostname for SSH/mosh sessions.
get_env_name() {
    [ -n "${CODESPACE_NAME:-}" ] && { echo "$CODESPACE_NAME"; return; }
    [ -n "${CODER_WORKSPACE_NAME:-}" ] && { echo "$CODER_WORKSPACE_NAME"; return; }
    [ -n "${SSH_CONNECTION:-}" ] || [ -n "${SSH_TTY:-}" ] ||
    [ "$(ps -o comm= -p "$PPID" 2>/dev/null)" = "mosh-server" ] &&
        hostname -s
}

# Build the base prompt: [env] ~/dir (branch)
# Outputs raw ANSI escapes. For shell prompts, pipe through wrap_prompt_escapes.
# Args: $1 = display dir (e.g. ~/foo), $2 = real dir for git (defaults to cwd).
build_base_prompt() {
    _dir="$1"
    _git_dir="${2:-.}"
    _branch=$(get_git_branch "$_git_dir")
    _env=$(get_env_name)

    _out=""
    [ -n "$_env" ] && _out=$(printf "\033[35m[%s]\033[0m " "$_env")
    _out="${_out}$(printf "\033[36m%s\033[0m" "$_dir")"
    [ -n "$_branch" ] && _out="${_out} $(printf "\033[33m(%s)\033[0m" "$_branch")"
    printf "%s" "$_out"
}

# Wrap ANSI escapes so the shell can calculate visible prompt length.
# Usage: build_base_prompt ~/dir | wrap_prompt_escapes bash
wrap_prompt_escapes() {
    _esc=$(printf '\033')
    case "$1" in
        zsh)  sed "s/${_esc}\[[0-9;]*m/%{&%}/g" ;;
        bash) sed "s/${_esc}\[[0-9;]*m/$(printf '\001')&$(printf '\002')/g" ;;
    esac
}
