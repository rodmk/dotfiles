.PHONY: lint install-packages install-tools hooks devcontainer

install-packages:
ifeq ($(shell uname),Darwin)
	brew install $(shell cat packages.txt)
else
	sudo apt-get update && sudo apt-get install -y $(shell cat packages.txt)
endif

install-tools:
	@command -v claude >/dev/null || curl -fsSL https://claude.ai/install.sh | bash
	@command -v uv >/dev/null || curl -LsSf https://astral.sh/uv/install.sh | sh
	@command -v devcontainer >/dev/null || curl -fsSL https://raw.githubusercontent.com/devcontainers/cli/main/scripts/install.sh | sh
	@command -v op >/dev/null || { \
		if [ "$$(uname)" = "Darwin" ]; then \
			brew install --cask 1password-cli; \
		else \
			curl -sSfo /tmp/op.deb "https://downloads.1password.com/linux/debian/$$(dpkg --print-architecture)/stable/1password-cli-$$(dpkg --print-architecture)-latest.deb" && \
			sudo dpkg -i /tmp/op.deb && \
			rm /tmp/op.deb; \
		fi; \
	}

lint:
	cd .. && git ls-files -z '*.sh' | xargs -0 -r shellcheck
	cd .. && git ls-files -z | xargs -0 -r grep -lZ '^# shellcheck shell=' | xargs -0 -r shellcheck

hooks:
	@git config core.hooksPath lib/githooks

devcontainer: install-tools
	@devcontainer up --workspace-folder ..
	@devcontainer exec --workspace-folder .. bash -l
