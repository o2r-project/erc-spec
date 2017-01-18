# ERC developer guide

An introduction to the ERC rational and the technology choices made within the project _Opening Reproducible Research_.
This documents is targeted at developers who wish to create tools for creating, validating, and consuming ERC.

## Convention over configuration

We want to create a directory structure with default file names and sensible defaults.
This way a typical research workspace should require only minimal configuration in 80% of the cases, while allowing to override each of the settings if need be and providing full customizability in the remaining 20%.

For example, the main command to compile the text manuscript in a bagtainer could be `knitr::knit("<*>.Rmd")`, with `<*>` being replaced by name of the first RMarkdown file.
However, if a user wants to use `rmarkdown::render(..)` on a file named `publication.md`, then the default behaviour can be overwritten.

## Reasoning and decisions

### Why nested containers

A user shall have access to the files without starting the runtime container.
Therefore we have at least two items, so we have a bundle and need an outer container.
As a bonus, the outer container can immediately be used to make an ERC conform to specific use cases, such as long term archival.

The alternative of putting everything into the container itself (e.g. using image labels for metadata) can be evaluated in the future.

### Why BagIt

...

### Why Docker

...

### Licensing information

Without proper license credits, the contents of an ERC would be useless based on today's copyright laws.
Therefore we rather have the extra work for authors to define a license than to create something that is unusable by others.

One of the biggest issues is the **scope of licenses**, namely what to do about having multiple pieces of code, text, or data with different licenses.

### Put the identifier into the ERC

- makes it easier to track across platforms
- is harder for manual creation

### Why use bash

> "What's oldest lasts longest." [via](https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/blob/gh-pages/index.md#supplementary-materials)

### Why is validation happening outside the container and not _in_ the container

- better user experience (otherwise all info must be transported via stdout)
- to be sure nothing is manipulated within the validation script

## o2r Platform

The software developed by the o2r project is the sole implementation of the ERC specification and hence a kind of reference implementation albeit being at a prototypical stage.

### Web API

[o2r Web API specification](http://o2r.info/o2r-web-api)

### Architecture

[o2r Architecture documentation](http://o2r.info/architecture/)
