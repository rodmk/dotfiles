# shellcheck shell=bash
brew_packages() { echo "gemini-cli"; }
apt_install() {
	command -v gemini >/dev/null && return
	npm install -g @google/gemini-cli
}
