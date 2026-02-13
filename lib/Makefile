.PHONY: lint install hooks

# packages.txt — shared names where `brew install X` and `apt-get install X`
# are the same. Just append a line.
#
# pre/*.sh — scripts that run before the package manager (e.g. adding an apt
# repo). `# brew: <formula>` and/or `# apt: <pkg>` batches the package name
# into a single brew/apt-get call. Scripts guard their own platform.
#
# post/*.sh — scripts that run after the package manager, in parallel. A
# `# brew:` or `# apt:` comment batches the install into the package manager
# on that platform and skips the script.
ifeq ($(shell uname),Darwin)
PKG_TAG     := brew
PKG_INSTALL := brew install
else
PKG_TAG     := apt
PKG_INSTALL := sudo apt-get update && sudo apt-get install -y
endif

PACKAGES := $(shell cat packages.txt) $(shell grep -rh '^\# $(PKG_TAG):' pre/ post/ | cut -d' ' -f3)

install:
	@for script in pre/*.sh; do bash "$$script"; done; true
	$(PKG_INSTALL) $(PACKAGES)
	@for script in post/*.sh; do grep -q '^# $(PKG_TAG):' "$$script" || bash "$$script" & done; wait

lint:
	cd .. && git ls-files -z '*.sh' | xargs -0 -r shellcheck
	cd .. && git ls-files -z | xargs -0 -r grep -lZ '^# shellcheck shell=' | xargs -0 -r shellcheck
	terraform -chdir=terraform init -backend=false -input=false
	terraform -chdir=terraform fmt -check
	terraform -chdir=terraform validate

hooks:
	@git config core.hooksPath lib/githooks
