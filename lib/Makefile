.PHONY: lint install-packages install-tools hooks

install-packages:
ifeq ($(shell uname),Darwin)
	brew install $(shell cat packages.txt)
else
	sudo apt-get update && sudo apt-get install -y $(shell cat packages.txt)
endif

install-tools:
	@command -v et >/dev/null || { \
		if [ "$$(uname)" = "Darwin" ]; then \
			brew install et; \
		else \
			sudo apt-get install -y software-properties-common && \
			sudo add-apt-repository -y ppa:jgmath2000/et && \
			sudo apt-get update && sudo apt-get install -y et; \
		fi; \
	}
	@command -v claude >/dev/null || curl -fsSL https://claude.ai/install.sh | bash
	@command -v uv >/dev/null || curl -LsSf https://astral.sh/uv/install.sh | sh
	@command -v op >/dev/null || { \
		if [ "$$(uname)" = "Darwin" ]; then \
			brew install --cask 1password-cli; \
		else \
			curl -sSfo /tmp/op.deb "https://downloads.1password.com/linux/debian/$$(dpkg --print-architecture)/stable/1password-cli-$$(dpkg --print-architecture)-latest.deb" && \
			sudo dpkg -i /tmp/op.deb && \
			rm /tmp/op.deb; \
		fi; \
	}
	@command -v hcloud >/dev/null || { \
		if [ "$$(uname)" = "Darwin" ]; then \
			brew install hcloud; \
		else \
			curl -sSLo /tmp/hcloud.tar.gz https://github.com/hetznercloud/cli/releases/latest/download/hcloud-linux-amd64.tar.gz && \
			sudo tar -C /usr/local/bin --no-same-owner -xzf /tmp/hcloud.tar.gz hcloud && \
			rm /tmp/hcloud.tar.gz; \
		fi; \
	}
	@command -v terraform >/dev/null || { \
		if [ "$$(uname)" = "Darwin" ]; then \
			brew install hashicorp/tap/terraform; \
		else \
			curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
			echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $$(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list && \
			sudo apt-get update && sudo apt-get install -y terraform; \
		fi; \
	}

lint:
	cd .. && git ls-files -z '*.sh' | xargs -0 -r shellcheck
	cd .. && git ls-files -z | xargs -0 -r grep -lZ '^# shellcheck shell=' | xargs -0 -r shellcheck
	terraform -chdir=terraform init -backend=false -input=false
	terraform -chdir=terraform fmt -check
	terraform -chdir=terraform validate

hooks:
	@git config core.hooksPath lib/githooks
