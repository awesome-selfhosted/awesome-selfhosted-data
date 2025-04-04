# requirements: git bash make python3-pip python3-venv
SHELL := /bin/bash
MARKDOWN_REPOSITORY = awesome-selfhosted/awesome-selfhosted
HTML_REPOSITORY = awesome-selfhosted/awesome-selfhosted-html

.PHONY: install # install build tools in a virtualenv
install:
	python3 -m venv .venv
	source .venv/bin/activate && \
	pip3 install wheel && \
	pip3 install --force git+https://github.com/nodiscc/hecat.git@1.4.0

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

.PHONY: awesome_lint # check data against awesome-selfhosted guidelines (strict)
awesome_lint_strict:
	source .venv/bin/activate && \
	hecat --config .hecat/awesome-lint-strict.yml

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
