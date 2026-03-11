# shellcheck shell=bash
apt_repo() {
	sudo mkdir -p -m 755 /etc/apt/keyrings
	wget -nv -O- https://cli.github.com/packages/githubcli-archive-keyring.gpg \
		| sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null
	sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
		| sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
}
packages() { echo "gh"; }
