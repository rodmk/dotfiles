.PHONY: lint install hooks

install:
	bash install-deps.sh

lint:
	cd .. && git ls-files -z '*.sh' | xargs -0 -r shellcheck
	cd .. && git grep -lz '^# shellcheck shell=' | xargs -0 shellcheck

hooks:
	@git config core.hooksPath lib/githooks
