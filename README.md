# awesome-selfhosted-data

This repository holds data used to generate https://github.com/awesome-selfhosted/awesome-selfhosted

**Status: [experimental](https://github.com/awesome-selfhosted/awesome-selfhosted-data/issues/11)**

## Contributing

Don't know where to start? Check issues labeled [`help wanted`](https://github.com/awesome-selfhosted/awesome-selfhosted-data/issues?q=is%3Aissue+is%3Aopen+label%3A%22help+wanted%22), [`fix`](https://github.com/awesome-selfhosted/awesome-selfhosted-data/issues?q=is%3Aissue+is%3Aopen+label%3Afix) and [`curation`](https://github.com/awesome-selfhosted/awesome-selfhosted-data/issues?q=is%3Aissue+is%3Aopen+label%3Acuration).

### Curation

- Software with no development activity for 6-12 months may be removed from the list
- Unmaintained software without an active community and/or persistent security issues may be removed from the list
- Problems should be reported automatically: [![](https://github.com/awesome-selfhosted/awesome-selfhosted-data/actions/workflows/ci.yml/badge.svg)](https://github.com/awesome-selfhosted/awesome-selfhosted-data/issues/1)

### Add software to the list

- [Create a new `software/software-name.yml` file](https://github.com/awesome-selfhosted/awesome-selfhosted-data/new/master/software), based on the template in [.github/ISSUE_TEMPLATES/addition.md](.github/ISSUE_TEMPLATE/addition.md). Please use [kebab-case](https://en.wikipedia.org/wiki/Letter_case#Kebab_case) for file naming, for example `my-awesome-software.yml`.
- Remove comments and unused optional fields
- Enter a descriptive commit message (such as `add My Awesome software`)
- Select `Create a new branch for this commit and start a pull request`
- Click `Propose new file`
- Click `Create pull request`

If you are not comfortable sending a pull request, please open a new [issue](https://github.com/awesome-selfhosted/awesome-selfhosted-data/issues).

In [single page mode](https://github.com/awesome-selfhosted/awesome-selfhosted) the software will only appear under the first category in its `tags` list, so choose wisely.

### Add a tag/category

Tags represent functional categories/features of the software. Any tag should have at least 3 list items attached to it, and be added to `tags/tag-name.yml` (use [existing tags](tags/) as example):

```yaml
# (required) project name
name: Project Management
 # (required) description of what this tag/category is about (markdown allowed)
description: '[Project management](https://en.wikipedia.org/wiki/Project_management) is the process of leading the work of a team to achieve all project goals within the given constraints.'
# (optional) list of related tags, by name
related_tags:
  - Ticketing
  - Task management & To-do lists
# (optional) external links
external_links:
  - title: awesome-sysadmin/Code Review
    url: https://github.com/awesome-foss/awesome-sysadmin#code-review
```

### Add a license

[Free and Open-Source](https://en.wikipedia.org/wiki/Free_and_open-source_software) software licenses (preferably [SPDX identifier](https://spdx.org/licenses/), or custom licenses, must be added to `licenses.yml` (use [existing licenses](licenses.yml) as example):

```yaml
# (required) license identifier
- identifier: ZPL-1.2
  # (required) full license name
  name: Zope Public License 1.2
  # (required) link to the full license text
  url: http://zpl.pub/page/zplv12
```

### Add a language/platform

Languages/requirements/technologies used to run or build the software should be listed in `platforms/platform-name.yml` (use [existing platforms](platforms/) as example):

```yaml
# (required) language/platform name
name: Java
# (required) general description of the programming language or deployment platform
description: "[Java](https://en.wikipedia.org/wiki/Java_(programming_language)) is a high-level, class-based, object-oriented programming language that is designed to have as few implementation dependencies as possible."
```

### Other

**Rename a tag/category:** the tag must be renamed in the appropriate `tags/mytag.yml` file. All references to it must be updated in `tags/*.yml` and `software/*.yml`.

**Automated tasks:**

```bash
$ make help
install             install build tools in a virtualenv
import              import data from original list at https://github.com/awesome-selfhosted/awesome-selfhosted
update_metadata     update metadata from project repositories/API
awesome_lint        check data against awesome-selfhosted guidelines
export              export markdown singlepage document from yaml data
url_check           check URLs for dead links or other connection problems
authors             update the AUTHORS file
help                generate list of targets with descriptions
```

## License

This list is under the [Creative Commons Attribution-ShareAlike 3.0 Unported License](LICENSE)
