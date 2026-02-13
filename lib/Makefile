.PHONY: lint install hooks

# packages.txt — things where `brew install X` and `apt-get install X` share
# the same name. Just append a line.
#
# tools/*.sh — everything else (different brew formula, no apt package, or a
# cross-platform curl installer). Each script has Linux install logic and a
# `command -v` guard. A `# brew: <formula>` comment means macOS installs it
# via brew (batched into one call); likewise `# apt: <package>` batches into
# apt-get. Scripts without a platform comment run everywhere.
ifeq ($(shell uname),Darwin)
PKG_TAG     := brew
PKG_INSTALL := brew install
else
PKG_TAG     := apt
PKG_INSTALL := sudo apt-get update && sudo apt-get install -y
endif

PACKAGES := $(shell cat packages.txt) $(shell grep -rh '^# $(PKG_TAG):' tools/ | cut -d' ' -f3)

install:
	$(PKG_INSTALL) $(PACKAGES)
	@for script in tools/*.sh; do grep -q '^# $(PKG_TAG):' "$$script" || bash "$$script"; done

lint:
	cd .. && git ls-files -z '*.sh' | xargs -0 -r shellcheck
	cd .. && git ls-files -z | xargs -0 -r grep -lZ '^# shellcheck shell=' | xargs -0 -r shellcheck
	terraform -chdir=terraform init -backend=false -input=false
	terraform -chdir=terraform fmt -check
	terraform -chdir=terraform validate

hooks:
	@git config core.hooksPath lib/githooks
