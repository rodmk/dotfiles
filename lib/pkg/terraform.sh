# shellcheck shell=bash
brew_packages() { echo "hashicorp/tap/terraform"; }
apt_packages() { echo "terraform"; }
apt_repo() {
	command -v terraform >/dev/null && return
	curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
}
