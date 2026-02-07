.PHONY: lint install-packages

install-packages:
ifeq ($(shell uname),Darwin)
	brew install $(shell cat packages.txt)
else
	sudo apt-get update && sudo apt-get install -y $(shell cat packages.txt)
endif
	@command -v claude >/dev/null || curl -fsSL https://claude.ai/install.sh | bash

lint:
	git ls-files -z '*.sh' | xargs -0 -r shellcheck
	git ls-files -z | xargs -0 -r grep -lZ '^# shellcheck shell=' | xargs -0 -r shellcheck
