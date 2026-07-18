# shellcheck shell=bash
apt_packages() { echo "apparmor-profiles apparmor-utils bubblewrap"; }

apt_install() {
	[ "${CODESPACES:-}" = true ] && return
	local extra_profile=/usr/share/apparmor/extra-profiles/bwrap-userns-restrict
	local active_profile=/etc/apparmor.d/bwrap-userns-restrict
	if [ -f "$extra_profile" ]; then
		sudo install -m 0644 "$extra_profile" "$active_profile"
		sudo apparmor_parser -r "$active_profile"
	fi
}
