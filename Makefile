SHELL := /bin/bash

.PHONY: install # install build tools in a virtualenv
install:
	python3 -m venv .venv
	source .venv/bin/activate && \
	pip3 install wheel && \
	pip3 install --force git+https://github.com/nodiscc/hecat.git@master

.PHONY: import # import data from original list at https://github.com/awesome-selfhosted/awesome-selfhosted
import: install
	rm -rf awesome-selfhosted && git clone --depth=1 https://github.com/awesome-selfhosted/awesome-selfhosted
	cp awesome-selfhosted/.github/.mailmap .mailmap
	cp awesome-selfhosted/AUTHORS.md AUTHORS.md
	rm -rf tags/ software/ platforms/
	mkdir -p tags/ software/ platforms/
	source .venv/bin/activate && \
	hecat --config .hecat/import.yml

.PHONY: update_metadata # update metadata from project repositories/API
update_metadata: install
	source .venv/bin/activate && \
	hecat --config .hecat/update-metadata.yml

.PHONY: url_check # check URLs for dead links or other connection problems
url_check: install
	source .venv/bin/activate && \
	hecat --config .hecat/url-check.yml

.PHONY: awesome_lint # check data against awesome-selfhosted guidelines
awesome_lint: install
	source .venv/bin/activate && \
	hecat --config .hecat/awesome-lint.yml

.PHONY: export # export markdown singlepage document from yaml data
export: install
	rm -rf awesome-selfhosted && git clone https://github.com/awesome-selfhosted/awesome-selfhosted
	source .venv/bin/activate && \
	hecat --config .hecat/export.yml
	cd awesome-selfhosted && git diff --color=always

.PHONY: help # generate list of targets with descriptions
help:
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1	\2/' | expand -t20
