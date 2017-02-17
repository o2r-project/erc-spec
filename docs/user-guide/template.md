# User guide: ERC template - WORK IN PROGRESS

If you want to create an ERC for your research already at the beginning, and not "post-hoc" after your research is complete, these templates can hopefully help.
They are divided into specific domains to be more concrete.

## Geoscience research in R

**Files in this template**

- `document.md` use RMarkdown, this is the main document
- `erc.yml` is template for the ERC configuration file with placeholders for all required fields
- `Dockerfile` is a template Dockerfile with some commands you can re-use to make sure all packages and tools that you need are installed

### Header templete

The yaml header of the document template file is the place to enter your meta information right away from the start: Fill out the included metadata fields as early in your personal workflow as possible and keep them up-to-date to prepare for the ERC creation progress.

```yml
---
author:
  - name: Your Name
    affiliation: Your affiliation
    orcid: Your ORCid
  - name: Your co-author's name
    affiliation: Their affiliation
    orcid: Their ORCids
title: The title of your publication
abstract:
  A concise description of your publication
keywords: [lorem, ipsum, dolor , sit, amet]
---
```


TODO: Provide the download zip-archive

**Filename** | **Template** | **ERC-Spec** 
------ | ------ | ------ |
[geo_template.zip]() _TBD_ | Geoscience research in R | V.1
