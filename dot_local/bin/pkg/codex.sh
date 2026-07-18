# shellcheck shell=bash
install() {
	command -v codex >/dev/null && return
	curl -fsSL https://chatgpt.com/codex/install.sh | CODEX_NON_INTERACTIVE=1 sh
}
