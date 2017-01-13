# ERC specification

An Exectuable Research Compendium (ERC) is a packaging convention for computational research.
It provides well-defined structure for data, code, documentation, and control of a piece of research and is suitable for long-term archival.

<div class="alert note" markdown="block">
This is a draft specification. If you have comments or suggestions please file them in the <a href="https://github.com/o2r-project/erc-spec/issues">issue tracker</a>. If you have explicit changes please fork the <a href="https://github.com/o2r-project/erc-spec">git repo</a> and submit a pull request.
</div>

## Version

This version of this specification is `1`.

## Table of contents

- [Introduction](index.md)
  - [Notational conventions](#notational-conventions)
  - [Purpose](#purpose)
  - [Fundamental concepts](#fundamental-concepts)
- [Structure](#erc-structure)
- [Mounting data](#mounting-data)
- [Security](#security)
- [BagIt extension](bagit.md)
- [R extension](r.md)
- [Glossary](glossary.md)

## Notational conventions

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" are to be interpreted as described in [RFC 2119][rfc2119].

The key words "unspecified", "undefined", and "implementation-defined" are to be interpreted as described in the [rationale for the C99 standard][c99-unspecified].

## Purpose

This specification defines a structure to carry and execute packaged scientific analyses.
These typically consist of data, the code and libraryies in executable form which are needed to replicate an analysis, and the outputs of the original  analysis.
This allows to collect  computational  research  in  a self-contained fashion and support transfer, archival, reproduction, and validation.

## Fundamental concepts

The bagtainer specification is inspired by two approaches to improve development and operation of software.
First,  [_"convention  over  configuration"_](https://en.wikipedia.org/wiki/Convention_over_configuration), e.g. as  practiced  in  the Java build tool [Maven](https://books.sonatype.com/mvnref-book/reference/installation-sect-conventionConfiguration.html).
Second, _"DevOps"_, see [Wikipedia](https://en.wikipedia.org/wiki/) or [Boettiger](http://dl.acm.org/citation.cfm?id=2723882).

Another core goal is _simplicity_, in the sense that this specification should not re-do something that already exists (if it is an open specification or tool) and it must be possible to create a valid and working ERC manually.

The final important notion is the one of _nested containers_.
Acknoledging that well defined standards exist for packaging a set of files, and that different approaches to create an executable code package, the collection of files that make up an ERC comprise one or more containers but are themselves subject to being put into a container.
We distinguish two containers.
The inner or "runtime" container and the outer container.

## How to interact with a bagtainer

The interaction steps with a bagtainer to (re-)run the contained analysis are as follows:

- (if compressed) open the bag
- execute the container
- (automatically) compare the output contained in the bag with the just created new output

## ERC structure

### Base directory

An ERC must have a _base directory_, whose name must only container characters, numbers, `_` (underscore) and `-` (minus sign).

**Regular expression**: `[a-zA-Z0-9\-_]`

The base directory MUST contain an [ERC configuration file](#erc-configuration-file) named `erc.yml`.

### ERC configuration file

#### Format

The file `erc.yml` MUST be valid [YAML 1.2](http://yaml.org/).

#### Required fields

The first document content of this file MUST contain the following string nodes at the root level.

- `spec-version`
- `id`

Minimal example:

```yml
id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
version: 1
```

#### Metadata

discovery, control, ...

#### Comprehensive example

```yml
id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
version: 1
mountpoint: "/erc"
payload_directory: "data"
config_file: "erc.yml"
container_file: "image.tar"
container_recipe: "Dockerfile"
command: "rmarkdown::render(input = 'paper.Rmd', output_format = )"
```

### Runtime container file

The base directory MUST contain a tape archive file of a Docker image.

The file SHOULD be named `image.tar`.

### Runtime container manifest

The base directory MUST contain a valid Dockerfile.
The Dockerfile MUST contain the build instructions for the runtime environment and MUST have been used to create the [runtime container file](#runtime-container-file).

The file SHOULD be named `Dockerfile`.

The Dockerfile MUST contain ...

## Optional elements

...

## Mounting data

How is data mounted into the container and where?

## Security considerations

Why are ERC not a security risk?

https://tools.ietf.org/html/draft-kunze-bagit-14#section-6

[c99-unspecified]: http://www.open-std.org/jtc1/sc22/wg14/www/C99RationaleV5.10.pdf#page=18
[rfc2119]: http://tools.ietf.org/html/rfc2119
[issues]: https://github.com/o2r-project/erc-spec/issues
[repo]: https://github.com/o2r-project/erc-spec
