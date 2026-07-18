# shellcheck shell=bash
apt_packages() { echo "apparmor-profiles apparmor-utils bubblewrap"; }

apt_install() {
	sudo install -m 0644 \
		/usr/share/apparmor/extra-profiles/bwrap-userns-restrict \
		/etc/apparmor.d/bwrap-userns-restrict
	sudo apparmor_parser -r /etc/apparmor.d/bwrap-userns-restrict
}
