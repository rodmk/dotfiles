.PHONY: lint

lint:
	git ls-files -z '*.sh' | xargs -0 -r shellcheck
	git ls-files -z | xargs -0 -r grep -lZ '^# shellcheck shell=' | xargs -0 -r shellcheck
