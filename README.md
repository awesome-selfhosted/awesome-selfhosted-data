# awesome-selfhosted-data

This repository holds data used to generate https://github.com/awesome-selfhosted/awesome-selfhosted

**Status: [experimental](https://github.com/awesome-selfhosted/awesome-selfhosted-data/issues/11)**

## Contributing

Don't know where to start? Check issues labeled [`help wanted`](https://github.com/awesome-selfhosted/awesome-selfhosted-data/issues?q=is%3Aissue+is%3Aopen+label%3A%22help+wanted%22), [`fix`](https://github.com/awesome-selfhosted/awesome-selfhosted-data/issues?q=is%3Aissue+is%3Aopen+label%3Afix) and [`curation`](https://github.com/awesome-selfhosted/awesome-selfhosted-data/issues?q=is%3Aissue+is%3Aopen+label%3Acuration).


### Maintenance

- Software with no development activity for 6-12 months may be removed from the list
- Unmaintained software without an active community and/or persistent security issues may be removed from the list
- Problems should be reported automatically: [![](https://github.com/awesome-selfhosted/awesome-selfhosted-data/actions/workflows/ci.yml/badge.svg)](https://github.com/awesome-selfhosted/awesome-selfhosted-data/issues/1)


### Add new software to the list

- [ ] Please submit one item per issue/pull request. This eases reviewing and speeds up the addition process.
- [ ] Please check that your addition is not already listed at any of these lists (If it fits in one of those lists, please try to get it added there instead):
  - [awesome-sysadmin](https://github.com/n1trux/awesome-sysadmin)
  - [awesome-analytics](https://github.com/onurakpolat/awesome-analytics)
  - [staticgen.com](https://www.staticgen.com/)
  - [staticsitegenerators.net](https://staticsitegenerators.net/)
- [ ] Please search for relevant [issues](https://github.com/awesome-selfhosted/awesome-selfhosted-data/issues) or [pull requests](https://github.com/awesome-selfhosted/awesome-selfhosted-data/pulls), including closed ones.
- [ ] [Create a new `.yml` file](https://github.com/awesome-selfhosted/awesome-selfhosted-data/new/master/software) based on the template below in the `software/` directory:

```yaml
# software/my-awesome-software.yml
name: "My awesome software" # required
website_url: "https://my.awesome.softwar.e" # required, URL of the software project's homepage
source_code_url: "https://gitlab.com/awesome/software" # if different from website_url, URL where the full source code of the program can be downloaded
description: "A description of my awesome software, shorter than 250 characters." # required
licenses: # required, see licenses.yml fro the full list of licenses
  - Apache-2.0
  - AGPL-3.0
platforms: # required, see platforms/ for the full list of platforms
  - Java
  - Python
  - PHP
  - Nodejs
  - Deb
  - Docker
tags: # required, , see tags/ for the full list of tags
  - Automation
  - Calendar
  - File synchronization
depends_3rdparty: yes # required if the software depends on a third-party service outside the user's control
demo_url: "https://my.awesome.softwar.e/demo" # optional, link to an interactive demo of the software
related_software_url: "https://my.awesome.softwar.e/apps" # optional, link to a list of clients/addons/plugins/apps/bots... for the software
```

- [ ] remove comments and unused optional fields
- [ ] enter a descriptive commit message (such as `add My Awesome software`)
- [ ] select `Create a new branch for this commit and start a pull request`
- [ } click `Propose new file`
- [ ] click `Create pull request`

If you are not comfortable sending a pull request, please copy/edit the template above and post it in a new [issue](https://github.com/awesome-selfhosted/awesome-selfhosted-data/issues)

In [single page mode](https://github.com/awesome-selfhosted/awesome-selfhosted) the software will only appear under the first category in its `tags` list, so choose wisely.


## Build the markdown list

```bash
make build
```

## Maintenance tasks

**Rename a tag/category:** the tag must be renamed in the appropriate `tags/mytag.yml` file. All references to it must be updated in `tags/*.yml` and `software/*.yml`.

**Add a tag/category:** Tags represent functional categories/features of the software. Any tag should have at least 3 list items attached to it, and be added to `tags/tag-name.yml` (use [existing tags](tags/) as example):

```yaml
name: Project Management # required
description: '[Project management](https://en.wikipedia.org/wiki/Project_management) is the process of leading the work of a team to achieve all project goals within the given constraints.' # required
related_tags: # list of related tags, by name
  - Ticketing
  - Task management & To-do lists
delegate_to: [] # URL to redirect to/link to domain-specific software list
external_links: # external links
  - title: awesome-sysadmin/Code Review
    url: https://github.com/awesome-foss/awesome-sysadmin#code-review
```

**Add a license:** [Free and Open-Source](https://en.wikipedia.org/wiki/Free_and_open-source_software) software licenses (preferably [SPDX identifier](https://spdx.org/licenses/), or custom licenses, must be added to `licenses.yml` (use [existing licenses](licenses.yml) as example):

```yaml
- identifier: ZPL-1.2
  name: Zope Public License 1.2
  url: http://zpl.pub/page/zplv12
```

**Add a platform:** languages/requirements/technologies used to run or build the software should be listed in `platforms/platform-name.yml` (use [existing platforms](platforms/) as example):

```yaml
name: Java
description: "[Java](https://en.wikipedia.org/wiki/Java_(programming_language)) is a high-level, class-based, object-oriented programming language that is designed to have as few implementation dependencies as possible."
```


## License

This list is under the [Creative Commons Attribution-ShareAlike 3.0 Unported License](LICENSE)
