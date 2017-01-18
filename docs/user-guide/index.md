# ERC user guide

This user guide comprises instructions how to create an ERC _by hand_.
It thus limited to mandatory elements in some places.
However, a fundamental goal of the ERC specification is to be simple enough to allow manualy ERC creation as demonstrated in this document.
For using tools or services for creation and validation of ERCs, please see the [developer guide](../dev-guide/index.md).

<div class="alert note" markdown="block">
This is a draft specification. If you have comments or suggestions please file them in the <a href="https://github.com/o2r-project/erc-spec/issues">issue tracker</a>. If you have explicit changes please fork the <a href="">git repo</a> and submit a pull request.
</div>

## Step 1: create workspace

_Do your research and create something useful that works for you._
The ERC specification makes no restrictions on the contents of a workspace, but guidelines and best practices do exist and should be followed by users during their research i.e. even before packaging it in an ERC.

### Code and versioning

If the base directory contains a script file or source code used to conduct the packaged analysis, we recoomend this code is managed using [distributed version control](https://en.wikipedia.org/wiki/Distributed_version_control), see [software carpentry guidelines](https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/blob/gh-pages/index.md#keeping-track-of-changes).
The base directory should contain a copy of the complete repository in that case.

### Workspace structure

The base directory contents should follow common guidelines to project organisation.
Some useful resources are

- [Software carpentry paper "Good enough practices in Scientific Computing"](https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/blob/gh-pages/index.md#project-organization)
- [ROpenSci research compendium](https://github.com/ropensci/rrrpkg)).
- [ROpenSci reproducibility guide](https://ropensci.github.io/reproducibility-guide/sections/introduction)

## Step 2: create container for runtime

Dockerfile

## Step 3: test container

run command and how to compare the output and the original

## Step 3: create metadata

### ERC metadata

structural & administrative metadata

`bagtainer.yml` or `erc.json`

container start command

### Content metadata

`erc_metadata.json` == `web-api/<compendium>.metadata.o2r`, or `bagit.txt`?

discovery metadata
(mandatory vs. optional)

## Step 5: validate ERC

...

## Step 4: create BagIt

create

validate
