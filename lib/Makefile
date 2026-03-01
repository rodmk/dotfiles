.PHONY: lint install hooks

install:
	bash ../dot_local/bin/executable_dotfiles-deps

lint:
	cd .. && git ls-files -z '*.sh' | xargs -0 -r shellcheck
	cd .. && git grep -lz '^# shellcheck shell=' | xargs -0 shellcheck

hooks:
	@git config core.hooksPath lib/githooks
