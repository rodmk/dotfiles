# shellcheck shell=bash
brew_packages() { echo "node"; }
apt_packages() { echo "nodejs"; }
apt_repo() {
	curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
}
