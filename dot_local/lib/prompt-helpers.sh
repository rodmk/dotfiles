# shellcheck shell=sh
# Shared prompt helpers — sourced by .shellrc and Claude statusline.

# Prompt colors (ANSI codes, defined once).
_CLR_ENV=35    # magenta
_CLR_DIR=36    # cyan
_CLR_BRANCH=33 # yellow

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

# Colorize text for the target shell. $1=mode $2=color-code $3=text
# Mode: zsh, bash, or ansi (default).
_color() {
    case "$1" in
        zsh)  printf "%%{\033[%sm%%}%s%%{\033[0m%%}" "$2" "$3" ;;
        bash) printf '\\[\\033[%sm\\]%s\\[\\033[0m\\]' "$2" "$3" ;;
        *)    printf "\033[%sm%s\033[0m" "$2" "$3" ;;
    esac
}

# Build the base prompt: [env] ~/dir (branch)
# Args: $1 = display dir, $2 = real dir for git (defaults to cwd), $3 = mode.
build_base_prompt() {
    _dir="$1"
    _git_dir="${2:-.}"
    _fmt="${3:-ansi}"
    _branch=$(get_git_branch "$_git_dir")
    _env=$(get_env_name)

    _out=""
    [ -n "$_env" ] && _out="$(_color "$_fmt" $_CLR_ENV "[${_env}]") "
    _out="${_out}$(_color "$_fmt" $_CLR_DIR "$_dir")"
    [ -n "$_branch" ] && _out="${_out} $(_color "$_fmt" $_CLR_BRANCH "(${_branch})")"
    printf "%s" "$_out"
}
