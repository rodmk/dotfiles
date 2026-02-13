# shellcheck shell=bash
brew_packages() { echo "hcloud"; }
apt_install() {
	command -v hcloud >/dev/null && return
	curl -sSLo /tmp/hcloud.tar.gz https://github.com/hetznercloud/cli/releases/latest/download/hcloud-linux-amd64.tar.gz
	sudo tar -C /usr/local/bin --no-same-owner -xzf /tmp/hcloud.tar.gz hcloud
	rm /tmp/hcloud.tar.gz
}
