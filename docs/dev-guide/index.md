# ERC developer guide

An introduction to the ERC rational and the technology choices made within the project _Opening Reproducible Research_.
This documents is targeted at developers who wish to create tools for creating, validating, and consuming ERC.

!!! note
    This is a draft. If you have comments or suggestions please file them in the <a href="https://github.com/o2r-project/erc-spec/issues">issue tracker</a>. If you have explicit changes please fork the <a href="https://github.com/o2r-project/erc-spec">git repo</a> and submit a pull request.

## Convention over configuration

We want to create a directory structure with default file names and sensible defaults.
This way a typical research workspace should require only minimal configuration in 80% of the cases, while allowing to override each of the settings if need be and providing full customizability in the remaining 20%.

For example, the main command to compile the text manuscript in a bagtainer could be `knitr::knit("<*>.Rmd")`, with `<*>` being replaced by name of the first RMarkdown file.
However, if a user wants to use `rmarkdown::render(..)` on a file named `publication.md`, then the default behaviour can be overwritten.

## Reasoning and decisions

### Some observations

- researchers do their thing and need independence/flexibility, so post-hoc creation will probably be most common and ERC must have low to no impact on workflow
- data storage, citation and preservation is solved (repos, bitstream preservation in archives)
- packaging methods/methodology is solved (R packages, Python packages, ...)
- software preservation is _not_ solved (methods are there, like migration, emulation, but complexity is too high to do this at high granularity)
- reproducible paper is solved (literate programming, R package dependency handling solutions, ..)
- computational RR requires sandboxing (to make sure everything is there as much as security)
- a service is needed to create ERC for researchers and executes them in a controlled environment

### Why nested containers

A user shall have access to the files without starting the runtime container.
Therefore we have at least two items, so we have a bundle and need an outer container.
As a bonus, the outer container can immediately be used to make an ERC conform to specific use cases, such as long term archival.

The alternative of putting everything into the container itself (e.g. using image labels for metadata) can be evaluated in the future.

### Why is the runtime image not mandatory

While having Docker in mind when writing the specification, an alternative idea always was to use the extension mechanisms of a given language environment, e.g. R, only to re-construct the runtime environment.
That is why the image is not mandatory.

### Why BagIt

...

### Why Docker

...

### Why not just use plain R?

It would be possible to rely solely on R for replication.
For example, the runtime manifest could be a codemeta document, and the runtime environment is created outside of the ERC when needed.
Alternatively, the packages for preserving a state of dependencies could be used.

However, none of these solutions touches the underlying system libraries.
Even if shipping system binaries within packages is possible (common?), some packages do use system libraries which are not preserved in a plain R approach.

Furthermure, none of the solutions for reproducibility are part of "core R", even if they are trustworthy (e.g. MRAN). CRAN does not support installing specific package versions.

That is why using an abstraction layer outside of R is preferable.

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

### Why is the data not in the image (inner contaienr) but in the outer container

- better accessible in the long term
- no data duplication

## o2r Platform

The software developed by the o2r project is the sole implementation of the ERC specification and hence a kind of reference implementation albeit being at a prototypical stage.

### Web API

[o2r Web API specification](http://o2r.info/o2r-web-api)

### Architecture

[o2r Architecture documentation](http://o2r.info/architecture/)
