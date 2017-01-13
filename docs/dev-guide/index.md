# ERC developer guide

An introduction to the ERC rational and the technology choices made within the project _Opening Reproducible Research_.
This documents is targeted at developers who wish to create tools for creating, validating, and consuming ERC.

## Convention over configuration

We want to create a directory structure with default file names and sensible defaults for settings that require only minimal configuration in 80% of the cases, while allowing to override each of the settings if need be and proving full customizability in the remaining 20%.

For example, the main command to compile the text manuscript in a bagtainer could be `knitr::knit("<*>.Rmd")`, with `<*>` being replaced by name of the first RMarkdown file.
However, if a user wants to use `rmarkdown::render(..)` on a file named `publication.md`, then the default behaviour can be overwritten.

## Why BagIt?


## Why Docker?

## o2r Platform

### Web API

### Architecture

