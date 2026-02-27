.PHONY: lint install hooks

install:
	bash install-deps.sh

lint:
	cd .. && git ls-files -z '*.sh' | xargs -0 -r shellcheck
	cd .. && git grep -lz '^# shellcheck shell=' | xargs -0 shellcheck
	terraform -chdir=terraform init -backend=false -input=false
	terraform -chdir=terraform fmt -check
	terraform -chdir=terraform validate

hooks:
	@git config core.hooksPath lib/githooks
