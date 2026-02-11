.PHONY: lint install-packages install-tools hooks

install-packages:
ifeq ($(shell uname),Darwin)
	brew install $(shell cat packages.txt) $(shell grep -rh '^# brew:' tools/ | cut -d' ' -f3)
else
	sudo apt-get update && sudo apt-get install -y $(shell cat packages.txt)
endif

install-tools:
ifeq ($(shell uname),Darwin)
	@for script in tools/*.sh; do grep -q '^# brew:' "$$script" || bash "$$script"; done
else
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
