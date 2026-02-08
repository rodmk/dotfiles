.PHONY: lint install-packages install-tools hooks

install-packages:
ifeq ($(shell uname),Darwin)
	brew install $(shell cat packages.txt)
else
	sudo apt-get update && sudo apt-get install -y $(shell cat packages.txt)
endif

install-tools:
	@command -v claude >/dev/null || curl -fsSL https://claude.ai/install.sh | bash
	@command -v uv >/dev/null || curl -LsSf https://astral.sh/uv/install.sh | sh

lint:
	cd .. && git ls-files -z '*.sh' | xargs -0 -r shellcheck
	cd .. && git ls-files -z | xargs -0 -r grep -lZ '^# shellcheck shell=' | xargs -0 -r shellcheck

hooks:
	@git config core.hooksPath lib/githooks
