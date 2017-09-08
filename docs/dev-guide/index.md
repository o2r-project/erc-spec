# ERC developer guide

An introduction to the ERC rational and the technology choices made within the project _Opening Reproducible Research_, and ideas for downstream products based on ERCs.
This documents is targeted at developers who wish to create tools for creating, validating, and consuming ERC.

!!! note
    This guide is a draft. If you have comments or suggestions please file them in the <a href="https://github.com/o2r-project/erc-spec/issues">issue tracker</a>. If you have explicit changes please fork the <a href="https://github.com/o2r-project/erc-spec">git repo</a> and submit a pull request.

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
Also the chosen outer container standard is much older and common than the inner container standard, and thus more likely to exist longer.

The alternative of putting everything into the container itself (e.g. using image labels for metadata) can be evaluated in the future.

### Why BagIt

...

### Why Docker

- (Docker) containers provide an encapsulation mechanism to package all dependencies of an anylsis
- during container execution, and substitution, the build in [copy-on-write](https://en.wikipedia.org/wiki/Copy-on-write) storage only creates copy of files that are changed within the container, thus saving storage capacity
- volume mounts allow easy substitution of input data and configurations of analysis

### Why not just use plain R?

It would be possible to rely solely on R for replication.
For example, the runtime manifest could be a [codemeta](https://codemeta.github.io/) document, and the runtime environment is created based on it outside of the ERC when needed, for example by installing R in the required version.
Additionally a package for preserving a state of dependencies could be used, e.g. [packrat](https://rstudio.github.io/packrat/).
This solution is potentially less storage intensive, because containers replicate an R installation each time.
Smaller storages might also ease collaboration.

However, none of these solutions touches the underlying system libraries.
The complexity of preserving the runtime environment is transferred from the packaging stage to the unpackaging stage, which is unfavourable because that packaging state "everything works", so better control is ensured at that time.
The burden in a plain R solution shifts from authoring to preservation.

Even though shipping system binaries within packages is possible (if not common), some packages do use system libraries which are not preserved in a plain R approach.
Adjusting such packages is not an option.

Furthermore, none of the solutions for reproducibility are part of "core R", even if they are trustworthy (e.g. MRAN). CRAN does not support installing specific package versions.

That is why using an abstraction layer outside of R is preferable.

### Licensing information

Without proper license credits, the contents of an ERC would be useless based on today's copyright laws.
Therefore we rather have the extra work for authors to define a license than to create something that is unusable by others.

One of the biggest issues is the **scope of licenses**, namely what to do about having multiple pieces of code, text, or data with different licenses.

### Put the identifier into the ERC

- makes it easier to track across platforms
- is harder for manual creation

### Why use bash

While it is true that..

> "What's oldest lasts longest." [via](https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/blob/gh-pages/index.md#supplementary-materials)

using containers gives the necessary abstraction and encapsulation, so simply using bash (or make) does not suffice.

### Why is validation happening outside the container and not _in_ the container

- better user experience (otherwise all info must be transported via stdout)
- to be sure nothing is manipulated within the validation script

### Why is the data not in the image (inner container) but in the outer container

- better accessible in the long term
- no data duplication

## o2r Platform

The software developed by the o2r project is the reference implementation of the ERC specification.

### Web API

[o2r Web API specification](http://o2r.info/o2r-web-api)

### Architecture

[o2r Architecture documentation](http://o2r.info/architecture/)

## ERC completeness score

While the ERC is intended to be simple enough to be created manually, the clear requirements on it's contents also serve a semi-automatic creation.
For example, a user can upload a workspace with data files, and R Markdown document, and an HTML rendering of the document to an online platform, where the runtime manifest and image are automatically created. In such a case, metadata would still be added manually.

To encourage users, especially during the manual steps of the creation process, to provide valuable input a **completeness score** can be useful.
Comparable to profile editors on social network sites, a percentage based score can be used to highlight content or aspects going beyond the mandatory requirements.

Implementing platforms may create their own rules, for example which of the optional metadata elements contribute towards reaching a full score.
Thinking beyond merely the metadata, the score could also cover the runtime manifest (e.g. does it follow common practices, include relevant independent metadata, uses explicit versioning for dependency installation), contained code (e.g. automatic checks against code formatting guidelines, syntactical errors), and contained data (e.g. are open file formats used, maybe rewarding CSV over Shapefiles).

A completeness score can be seen as a _downstream product_ based on the ERC.
It is unlikely this ever makes it into an ERC specification, but it can be a crucial means towards acceptance, adoption, and success of ERCs.