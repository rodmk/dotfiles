#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ "$(uname)" = "Darwin" ]; then
	TAG=brew
	pkg_install() { brew install "$@"; }
else
	TAG=apt
	pkg_install() { sudo apt-get install -y "$@"; }
fi

FUNCS=(packages "${TAG}_packages" "${TAG}_repo" "${TAG}_install" install)
unset_funcs() { unset -f "${FUNCS[@]}" 2>/dev/null; }

pkgs=()
tag_installers=()
generic_installers=()

# Each pkg/*.sh file can define: packages, ${TAG}_packages, ${TAG}_repo,
# ${TAG}_install (uses pkg manager), or install (standalone).
# Collect them all before running anything.
for f in "$SCRIPT_DIR"/pkg/*.sh; do
	unset_funcs
	# shellcheck disable=SC1090
	source "$f"

	if declare -f "${TAG}_repo" >/dev/null; then "${TAG}_repo"; fi

	if declare -f packages >/dev/null; then read -ra p < <(packages); pkgs+=("${p[@]}"); fi
	if declare -f "${TAG}_packages" >/dev/null; then read -ra p < <("${TAG}_packages"); pkgs+=("${p[@]}"); fi
	if declare -f "${TAG}_install" >/dev/null; then
		tag_installers+=("${TAG}_install:$f")
	elif declare -f install >/dev/null; then
		generic_installers+=("install:$f")
	fi
done
unset_funcs

run_installer() {
	local func="${1%%:*}" file="${1#*:}"
	unset_funcs
	# shellcheck disable=SC1090
	source "$file"
	"$func"
}

# Standalone installers run in parallel (no shared locks)
for entry in "${generic_installers[@]}"; do
	(run_installer "$entry") &
done

# Package-manager installs run sequentially (shared dpkg/brew lock)
if [ ${#pkgs[@]} -gt 0 ]; then
	[ "$TAG" = "apt" ] && sudo apt-get update
	pkg_install "${pkgs[@]}"
fi
for entry in "${tag_installers[@]}"; do
	run_installer "$entry"
done

wait
