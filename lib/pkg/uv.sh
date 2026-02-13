# shellcheck shell=bash
install() {
	command -v uv >/dev/null && return
	curl -LsSf https://astral.sh/uv/install.sh | sh
}
