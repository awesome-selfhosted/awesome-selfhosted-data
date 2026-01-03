# Contributing

Don't know where to start? Check issues labeled [`help wanted`](https://github.com/awesome-selfhosted/awesome-selfhosted-data/issues?q=is%3Aissue+is%3Aopen+label%3A%22help+wanted%22), [`bug`](https://github.com/awesome-selfhosted/awesome-selfhosted-data/issues?q=is%3Aissue+is%3Aopen+label%3Abug) and [`curation`](https://github.com/awesome-selfhosted/awesome-selfhosted-data/issues?q=is%3Aissue+is%3Aopen+label%3Acuration).

### Curation

- Software with no development activity for 6-12 months may be removed from the list
- Non-working software may be removed from the list
- Unmaintained software without an active community may be removed from the list
- Software with persistent, serious security issues will be removed from the list
- Problems should be reported automatically: [![](https://github.com/awesome-selfhosted/awesome-selfhosted-data/actions/workflows/check-dead-links.yml/badge.svg)](https://github.com/awesome-selfhosted/awesome-selfhosted-data/issues/1) [![](https://github.com/awesome-selfhosted/awesome-selfhosted-data/actions/workflows/check-unmaintained-projects.yml/badge.svg)](https://github.com/awesome-selfhosted/awesome-selfhosted-data/issues/1)

### Add software to the list

- [Create a new `software/software-name.yml` file](https://github.com/awesome-selfhosted/awesome-selfhosted-data/new/master/software), based on the template in [.github/ISSUE_TEMPLATES/addition.md](.github/ISSUE_TEMPLATE/addition.md). Please use [kebab-case](https://en.wikipedia.org/wiki/Letter_case#Kebab_case) for file naming, for example, `my-awesome-software.yml`.
- Remove comments and unused optional fields
- Enter a descriptive commit message (such as `add My Awesome software`)
- Select `Create a new branch for this commit and start a pull request`
- Click `Propose new file`
- Click `Create pull request`

If you are not comfortable sending a pull request, please open a new [issue](https://github.com/awesome-selfhosted/awesome-selfhosted-data/issues).

In [single page mode](https://github.com/awesome-selfhosted/awesome-selfhosted) the software will only appear under the first category in its `tags` list, so choose wisely.


### Add a tag/category

Tags represent functional categories/features of the software and must be added to `tags/tag-name.yml` (use [existing tags](tags/) as an example). Any tag must have a minimum of 3 software projects referencing it. The [`Miscellaneous`](tags/miscellaneous.yml) tag can be used for software not matching any existing category.

```yaml
# project name
name: Project Management
# description of what this tag/category is about (markdown allowed)
description: '[Project management](https://en.wikipedia.org/wiki/Project_management) is the process of leading the work of a team to achieve all project goals within the given constraints.'
# (optional) list of related tags, by name
related_tags:
  - Ticketing
  - Task management & To-do lists
# (optional) external links
external_links:
  - title: awesome-sysadmin/Code Review
    url: https://github.com/awesome-foss/awesome-sysadmin#code-review
# (optional) if this is set, no software items will be allowed to reference this tag, and the page will display a block asking to visit these links instead
redirect:
  - title: awesome-sysadmin/Continuous Integration & Continuous Deployment
    url: https://github.com/awesome-foss/awesome-sysadmin#continuous-integration--continuous-deployment

```

### Add a license

[Free and Open-Source](https://en.wikipedia.org/wiki/Free_and_open-source_software) software licenses (preferably [SPDX identifier](https://spdx.org/licenses/), or custom licenses, must be added to `licenses.yml` (use [existing licenses](licenses.yml) as an example):

```yaml
  # short license identifier
- identifier: ZPL-1.2
  # full license name
  name: Zope Public License 1.2
  # link to the full license text
  url: http://zpl.pub/page/zplv12
```

### Add a language/platform

Languages/requirements/technologies used to run or build the software should be listed in `platforms/platform-name.yml` (use [existing platforms](platforms/) as an example):

```yaml
# language/platform name
name: Java
# general description of the programming language or deployment platform (markdown allowed)
description: "[Java](https://en.wikipedia.org/wiki/Java_(programming_language)) is a high-level, class-based, object-oriented programming language that is designed to have as few implementation dependencies as possible."
```

### Remove software from the list

Simply delete the appropriate file under `software/` and submit a Pull Request.
To do this from Github's web interface:
- use the [go to file](https://github.com/awesome-selfhosted/awesome-selfhosted-data?search=1) feature to open the appropriate file (e.g. [`software/redash.yml`](https://github.com/awesome-selfhosted/awesome-selfhosted-data/blob/master/software/redash.yml))
- Click the `...` button at the top right of the file view, and click `Delete file`
- In the `Commit changes` dialog, enter `Remove SOFTWARE_NAME (reason)` as your commit message, additional context in the `extended description` field, select `Create a new branch for this commit and start a pull request.`, and click `Commit Changes`


### Domain name costs

You can help cover domain name registration and renewal costs by pledging a small amount on [Liberapay ![](https://img.shields.io/liberapay/goal/awesome-selfhosted?logo=liberapay) ![](https://img.shields.io/liberapay/receives/awesome-selfhosted?logo=liberapay)](https://liberapay.com/awesome-selfhosted/)


### Other guidelines

In addition to guidelines listed in the [Pull Request template](.github/PULL_REQUEST_TEMPLATE.md), these general rules help keep the list consistent:
- Please avoid redundant terms in project descriptions, such as _open-source_, _free_, _self-hosted_... as their presence on awesome-selfhosted already implies this.
- Prefer shorter forms for descriptions - for example, `Minimalist text adventure game` would be preferred to `A minimalist text adventure game` or `$PROJECT is a minimalist text adventure game`).
- If the the project has no documentation in English, please add `(documentation in $LANGUAGE)` at the end of the description.
- If the project is presented as an alternative to another service or application, please mention it as `(alternative to $PRODUCT1, $PRODUCT2)` at the end of the description.
- If you are adding software forked from another active project, please provide/link to a clear list of differences between both.
- If the project is forked from another project, please add `(fork of $PROJECT)` at the end of the description.
- If the project distributes a single static binary, please add the programming language in which it is written.

### What does not qualify

- Software that depends on a specific cloud provider
- Software that is a desktop, mobile, or command-line application, which relies on a separate file synchronisation/server program
- Software that requires you to write application code before producing a working end-user application (libraries, SDKs, ...)
- Software acts as a platform to build and deploy arbitrary applications (PaaS, "serverless"...)
- Anything that is a generic container/deployment automation/virtualization/... tool is better suited for [awesome-sysadmin](https://github.com/awesome-foss/awesome-sysadmin)
- Software contributions that merely port an existing application to another system (e.g., Dockerization)

### Canned replies

To save maintainers time, a few premade replies for common issues can be found below

#### No tagged releases

>Hi, thanks for your contribution.
>
>However, there are no tagged releases for this project. Our guidelines require that _Any software project you are adding was first released more than 4 months ago._ We encourage you to create a release now and/or a simple [changelog](https://keepachangelog.com/en/1.1.0/) that will help users keep track of changes in the software (especially breaking changes or changes requiring configuration tweaks), and will allow administrators to install a known working, unchanging version (as opposed to always installing the latest development version).
>
>Once this is done, the project may be resubmitted to awesome-selfhosted when the first release reaches the age of 4 months.
>
>Thanks for understanding, and good luck with this project.

#### First release less than 4 months old

>Hi, thanks for your contribution.
>
>Currently, this project has a release, but it is not yet 4 months old. Our guidelines require that Any software project you are adding was first released more than 4 months ago. This count initiates only after a release has been created to ensure users need not rely on the latest development version to use the project.
>
>I'll go ahead and close it for now to keep the PR section focused on active tasks. Once the first release is four months old, feel free to resubmit it to awesome-selfhosted, or you can create an issue instead (we don't close issues; we just tag them to indicate they need to mature).
>
>Thanks for understanding, and good luck with this project.

### Other operations

**Rename a tag/category:** the tag must be renamed in the appropriate `tags/mytag.yml` file. All references to it must be updated in `tags/*.yml` and `software/*.yml`.

**Automated tasks:**

```bash
$ make help
install             install build tools in a virtualenv
import              import data from the original list at https://github.com/awesome-selfhosted/awesome-selfhosted
update_metadata     update metadata from project repositories/API
awesome_lint        check data against awesome-selfhosted guidelines
export_markdown     render markdown export from YAML data (https://github.com/awesome-selfhosted/awesome-selfhosted)
export_html         render HTML export from YAML data (https://awesome-selfhosted.net)
push_markdown       commit and push changes to the markdown repository
push_html           commit and push changes to the HTML site repository (amend previous commit and force-push)
url_check           check URLs for dead links or other connection problems
authors             update the AUTHORS file
clean               clean files generated by automated tasks
help                generate a list of targets with descriptions
```
