# shellcheck shell=bash
brew_packages() { echo "1password-cli"; }
apt_install() {
	command -v op >/dev/null && return
	curl -sSfo /tmp/op.deb "https://downloads.1password.com/linux/debian/$(dpkg --print-architecture)/stable/1password-cli-$(dpkg --print-architecture)-latest.deb"
	sudo dpkg -i /tmp/op.deb
	rm /tmp/op.deb
}
