# shellcheck shell=bash
brew_packages() { echo "MisterTea/et/et"; }
apt_packages() { echo "et"; }
apt_repo() {
	command -v add-apt-repository >/dev/null || { sudo apt-get update && sudo apt-get install -y software-properties-common; }
	sudo add-apt-repository -y --no-update ppa:jgmath2000/et
}
