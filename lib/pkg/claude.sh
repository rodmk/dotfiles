# shellcheck shell=bash
install() {
	command -v claude >/dev/null && return
	curl -fsSL https://claude.ai/install.sh | bash
}
