#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ "$(uname)" = "Darwin" ]; then
	TAG=brew
	pkg_install() { brew install "$@"; }
else
	TAG=apt
	pkg_install() { sudo apt-get update && sudo apt-get install -y "$@"; }
fi

FUNCS=(packages "${TAG}_packages" npm_packages "${TAG}_repo" "${TAG}_install" install)
unset_funcs() { unset -f "${FUNCS[@]}" 2>/dev/null; }

pkgs=()
npm_pkgs=()
installers=()

# Source each file, run repos, collect packages and installers
for f in "$SCRIPT_DIR"/pkg/*.sh; do
	unset_funcs
	# shellcheck disable=SC1090
	source "$f"

	if declare -f "${TAG}_repo" >/dev/null; then "${TAG}_repo"; fi

	if declare -f packages >/dev/null; then read -ra p < <(packages); pkgs+=("${p[@]}"); fi
	if declare -f "${TAG}_packages" >/dev/null; then read -ra p < <("${TAG}_packages"); pkgs+=("${p[@]}"); fi
	if declare -f npm_packages >/dev/null; then read -ra p < <(npm_packages); npm_pkgs+=("${p[@]}"); fi

	if declare -f "${TAG}_install" >/dev/null; then
		installers+=("${TAG}_install:$f")
	elif declare -f install >/dev/null; then
		installers+=("install:$f")
	fi
done
unset_funcs

# Batch package-manager install
if [ ${#pkgs[@]} -gt 0 ]; then
	pkg_install "${pkgs[@]}"
fi

# npm global install
if [ ${#npm_pkgs[@]} -gt 0 ]; then
	sudo npm install -g "${npm_pkgs[@]}"
fi

# Custom installers (parallel)
for entry in "${installers[@]}"; do
	func="${entry%%:*}" file="${entry#*:}"
	(
		unset_funcs
		# shellcheck disable=SC1090
		source "$file"
		"$func"
	) &
done
wait
