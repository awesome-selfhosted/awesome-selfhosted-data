# requirements: git bash make python3-pip python3-venv
SHELL := /bin/bash
MARKDOWN_REPOSITORY = awesome-selfhosted/awesome-selfhosted
HTML_REPOSITORY = awesome-selfhosted/awesome-selfhosted-html

# OpenSSF Scorecard gate (see tools/scorecard-check.sh). Pinned binary + sha256.
SCORECARD_VERSION ?= 5.5.0
SCORECARD_SHA256 ?= 83b90a05c1540ef1390db1cd5711e5fd04be9c1d8537fb84d39d02092d6a8dff
SCORECARD_BIN = ./bin/scorecard
# Minimum aggregate score (0-10) a submitted GitHub/GitLab repository must reach.
SCORECARD_THRESHOLD ?= 5.0
# Base ref to diff added/modified software/*.yml against (the PR target branch).
SCORECARD_BASE ?= origin/master
# Set to a non-empty value to also fail when a repo cannot be evaluated (default: skip).
SCORECARD_STRICT ?=
# Set to check a single repo (host/owner/name) instead of the PR diff.
SCORECARD_REPO ?=

.PHONY: install # install build tools in a virtualenv
install:
	python3 -m venv .venv
	source .venv/bin/activate && \
	pip3 install wheel && \
	pip3 install --force git+https://github.com/nodiscc/hecat.git@1.6.0

.PHONY: import # import data from the original list at https://github.com/awesome-selfhosted/awesome-selfhosted
import: clean install
	git clone --depth=1 https://github.com/awesome-selfhosted/awesome-selfhosted
	cp awesome-selfhosted/AUTHORS AUTHORS
	rm -rf tags/ software/ platforms/
	mkdir -p tags/ software/ platforms/
	source .venv/bin/activate && \
	hecat --config .hecat/import.yml

.PHONY: update_metadata # update metadata from project repositories/API
update_metadata:
	source .venv/bin/activate && \
	hecat --config .hecat/update-metadata.yml

.PHONY: awesome_lint # check data against awesome-selfhosted guidelines
awesome_lint:
	source .venv/bin/activate && \
	hecat --config .hecat/awesome-lint.yml

.PHONY: awesome_lint_strict # check data against awesome-selfhosted guidelines (strict)
awesome_lint_strict:
	source .venv/bin/activate && \
	hecat --config .hecat/awesome-lint-strict.yml

.PHONY: install_scorecard # download the pinned OpenSSF Scorecard binary to ./bin/
install_scorecard:
	@if [ -x "$(SCORECARD_BIN)" ] && "$(SCORECARD_BIN)" version 2>/dev/null | grep -q "$(SCORECARD_VERSION)"; then \
		echo "scorecard $(SCORECARD_VERSION) already installed at $(SCORECARD_BIN)"; \
	else \
		mkdir -p bin; \
		tmp=$$(mktemp -d); \
		echo "downloading scorecard $(SCORECARD_VERSION)..."; \
		curl -fsSL -o "$$tmp/scorecard.tar.gz" "https://github.com/ossf/scorecard/releases/download/v$(SCORECARD_VERSION)/scorecard_$(SCORECARD_VERSION)_linux_amd64.tar.gz"; \
		echo "$(SCORECARD_SHA256)  $$tmp/scorecard.tar.gz" | sha256sum -c -; \
		tar -xzf "$$tmp/scorecard.tar.gz" -C "$$tmp" scorecard; \
		mv "$$tmp/scorecard" "$(SCORECARD_BIN)"; \
		chmod +x "$(SCORECARD_BIN)"; \
		rm -rf "$$tmp"; \
		echo "installed $(SCORECARD_BIN) ($(SCORECARD_VERSION))"; \
	fi

.PHONY: scorecard # check submitted software repositories against OpenSSF Scorecard
scorecard: install_scorecard
	SCORECARD_BIN='$(SCORECARD_BIN)' \
	SCORECARD_THRESHOLD='$(SCORECARD_THRESHOLD)' \
	SCORECARD_BASE='$(SCORECARD_BASE)' \
	SCORECARD_STRICT='$(SCORECARD_STRICT)' \
	SCORECARD_REPO='$(SCORECARD_REPO)' \
	bash tools/scorecard-check.sh

.PHONY: export_markdown # render markdown export from YAML data (https://github.com/awesome-selfhosted/awesome-selfhosted)
export_markdown:
	rm -rf awesome-selfhosted/
	git clone https://github.com/$(MARKDOWN_REPOSITORY)
	source .venv/bin/activate && hecat --config .hecat/export-markdown.yml
	cd awesome-selfhosted && git diff --color=always

.PHONY: export_html # render HTML export from YAML data (https://awesome-selfhosted.net/)
export_html:
	rm -rf awesome-selfhosted-html/ html/
	git clone https://github.com/$(HTML_REPOSITORY)
	mkdir html && source .venv/bin/activate && hecat --config .hecat/export-html.yml
	sed -i 's|<a href="https://github.com/pradyunsg/furo">Furo</a>|<a href="https://github.com/nodiscc/hecat/">hecat</a>, <a href="https://www.sphinx-doc.org/">sphinx</a> and <a href="https://github.com/pradyunsg/furo">furo</a>. Content under <a href="https://github.com/awesome-selfhosted/awesome-selfhosted-data/blob/master/LICENSE">CC-BY-SA 3.0</a> license. <a href="https://github.com/awesome-selfhosted/awesome-selfhosted-html">Source code</a>, <a href="https://github.com/awesome-selfhosted/awesome-selfhosted-data">raw data</a>.|' .venv/lib/python*/site-packages/furo/theme/furo/page.html
	source .venv/bin/activate && sphinx-build -b html -c .hecat/ html/md/ html/html/
	rm -rf html/html/.buildinfo html/html/objects.inv html/html/.doctrees awesome-selfhosted-html/*
	echo "# please do not scrape this site aggressively. Source code is available at https://github.com/awesome-selfhosted/awesome-selfhosted-html. Raw data is available at https://github.com/awesome-selfhosted/awesome-selfhosted-data" >| html/html/robots.txt

.PHONY: push_markdown # commit and push changes to the markdown repository
push_markdown:
	$(eval COMMIT_HASH=$(shell git rev-parse --short HEAD))
	cd awesome-selfhosted && git remote set-url origin git@github.com:$(MARKDOWN_REPOSITORY)
	cd awesome-selfhosted && git config user.name awesome-selfhosted-bot && git config user.email github-actions@github.com
	cd awesome-selfhosted && git add . && (git diff-index --quiet HEAD || git commit -m "[bot] build markdown from awesome-selfhosted-data $(COMMIT_HASH)")
	cd awesome-selfhosted && git push -f

.PHONY: push_html # commit and push changes to the HTML site repository (amend previous commit and force-push)
push_html:
	$(eval COMMIT_HASH=$(shell git rev-parse --short HEAD))
	mv html/html/* awesome-selfhosted-html/
	cd awesome-selfhosted-html/ && git remote set-url origin git@github.com:$(HTML_REPOSITORY)
	cd awesome-selfhosted-html/ && git config user.name awesome-selfhosted-bot && git config user.email github-actions@github.com
	cd awesome-selfhosted-html/ && git add . && (git diff-index --quiet HEAD || git commit --amend -m "[bot] build HTML from awesome-selfhosted-data $(COMMIT_HASH)")
	cd awesome-selfhosted-html/ && git push -f

.PHONY: url_check # check URLs for dead links or other connection problems
url_check:
	source .venv/bin/activate && \
	hecat --config .hecat/url-check.yml

.PHONY: authors # update the AUTHORS file
authors:
	printf "Commits|Author\n-------|---------------------------------------------------\n" > AUTHORS
	git shortlog -sne | grep -v awesome-selfhosted-bot >> AUTHORS

.PHONY: clean # clean files generated by automated tasks
clean:
	rm -rf awesome-selfhosted/ awesome-selfhosted-html/ html/

.PHONY: help # generate list of targets with descriptions
help:
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1	\2/' | expand -t20
