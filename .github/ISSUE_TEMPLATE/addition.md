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
name: "My awesome software" # required
website_url: "https://my.awesome.softwar.e" # required, URL of the software project's homepage
source_code_url: "https://gitlab.com/awesome/software" # required, URL where the full source code of the program can be downloaded
description: "A description of my awesome software, shorter than 250 characters." # required
licenses: # required, see licenses.yml for the full list of licenses
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

To ensure your issue is dealt with swiftly please check the following:

- [ ] Submit one item per pull request. This eases reviewing and speeds up inclusion.
- [ ] Values of the `language` fields are the main **server-side** requirements for the software. Don't include frameworks or specific dialects.
- [ ] Any software project you are adding to the list is actively maintained.
