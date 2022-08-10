---
name: Addition
about: Add new software to the list.
title: Add SOFTWARE_NAME
labels: addition
assignees: ''

---

Thanks for taking the time to suggest an addition to awesome-selfhosted! 

Please fill out information below:

```yaml
# software/my-awesome-software.yml
name: "My awesome software"
# required, URL of the software project's homepage
website_url: "https://my.awesome.softwar.e"
# required, URL where the full source code of the program can be downloaded
source_code_url: "https://gitlab.com/awesome/software"
# required, description of what the software does, shorter than 250 characters, sentence case
description: "Description of my awesome software."
# required, see licenses.yml for the full list of licenses
licenses:
  - Apache-2.0
  - AGPL-3.0
# required, see platforms/ for the full list of platforms
platforms:
  - Java
  - Python
  - PHP
  - Nodejs
  - Deb
  - Docker
# required, see tags/ for the full list of tags
tags:
  - Automation
  - Calendar
  - File synchronization
# required if the software depends on a third-party service outside the user's control, else remove
depends_3rdparty: yes
# optional, link to an interactive demo of the software
demo_url: "https://my.awesome.softwar.e/demo"
# optional, link to a list of clients/addons/plugins/apps/bots... for the software
related_software_url: "https://my.awesome.softwar.e/apps"
```

To ensure your issue is dealt with swiftly please check the following (check the boxes `[x]`):
- [ ] You have searched the repository for any relevant [issues](https://github.com/awesome-selfhosted/awesome-selfhosted-data/issues) or [PRs](https://github.com/awesome-selfhosted/awesome-selfhosted-data/pulls), including closed ones.
- [ ] Submit one item per pull request. This eases reviewing and speeds up inclusion.
- [ ] Values for `platform` are the main **server-side** requirements for the software. Don't include frameworks or specific dialects.
- [ ] Any software project you are adding to the list is actively maintained.
- [ ] If creating new `tags`, any tag has the minimum requirement of 3 items. If not, your addition may be inserted into `Miscellaneous`.
