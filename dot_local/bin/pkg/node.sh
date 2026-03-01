# shellcheck shell=bash
# renovate: datasource=node-version depName=node versioning=node
NODE_VERSION=v22.22.0

brew_packages() { echo "node"; }
apt_install() {
	command -v node >/dev/null && return
	local deb_arch node_arch
	deb_arch=$(dpkg --print-architecture)
	case "$deb_arch" in
		amd64) node_arch=x64 ;;
		*)     node_arch=$deb_arch ;;
	esac
	curl -sSLo /tmp/node.tar.xz "https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-${node_arch}.tar.xz"
	sudo tar -C /usr/local --strip-components=1 --no-same-owner -xJf /tmp/node.tar.xz
	rm /tmp/node.tar.xz
}
