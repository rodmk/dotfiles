.PHONY: lint install hooks

# packages.txt — things where `brew install X` and `apt-get install X` share
# the same name. Just append a line.
#
# tools/*.sh — everything else (different brew formula, no apt package, or a
# cross-platform curl installer). Each script has Linux install logic and a
# `command -v` guard. A `# brew: <formula>` comment means macOS installs it
# via brew (batched into one call); scripts without that line run everywhere.
install:
ifeq ($(shell uname),Darwin)
	brew install $(shell cat packages.txt) $(shell grep -rh '^# brew:' tools/ | cut -d' ' -f3)
	@for script in tools/*.sh; do grep -q '^# brew:' "$$script" || bash "$$script"; done
else
	sudo apt-get update && sudo apt-get install -y $(shell cat packages.txt)
	@for script in tools/*.sh; do bash "$$script"; done
endif

lint:
	cd .. && git ls-files -z '*.sh' | xargs -0 -r shellcheck
	cd .. && git ls-files -z | xargs -0 -r grep -lZ '^# shellcheck shell=' | xargs -0 -r shellcheck
	terraform -chdir=terraform init -backend=false -input=false
	terraform -chdir=terraform fmt -check
	terraform -chdir=terraform validate

hooks:
	@git config core.hooksPath lib/githooks
