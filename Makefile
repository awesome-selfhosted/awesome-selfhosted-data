SHELL := /bin/bash

.PHONY: install # install in a virtualenv
install:
	python3 -m venv .venv
	source .venv/bin/activate && \
	pip3 install git+https://github.com/nodiscc/hecat.git@master

.PHONY: import # import data from original list at https://github.com/awesome-selfhosted/awesome-selfhosted
import: install
	rm -rf awesome-selfhosted && git clone --depth=1 https://github.com/awesome-selfhosted/awesome-selfhosted
	cp awesome-selfhosted/.github/.mailmap .mailmap
	cp awesome-selfhosted/AUTHORS.md AUTHORS.md
	mkdir -p {tags,software,platforms}
	source .venv/bin/activate && \
	hecat import --source-file awesome-selfhosted/README.md --output-directory ./

.PHONY: build # build markdown singlepage document from yaml data
build: install
	rm -rf awesome-selfhosted && git clone https://github.com/awesome-selfhosted/awesome-selfhosted
	source .venv/bin/activate && \
	hecat build --source-directory ./ --output-directory awesome-selfhosted --output-file README.md
	cd awesome-selfhosted && git diff --color=always
