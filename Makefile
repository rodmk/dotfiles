.PHONY: lint

lint:
	git ls-files -z '*.sh' 'dot_*rc' | xargs -0 -r shellcheck
