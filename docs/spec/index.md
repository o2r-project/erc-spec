# ERC specification

An Exectuable Research Compendium (ERC) is a packaging convention for computational research.
It provides a well-defined structure for data, code, documentation, and control of a piece of research and is suitable for long-term archival. As such it can also be perceived as an object or more specifically: a digital asset.

<div class="alert note" markdown="block">
This is a draft specification. If you have comments or suggestions please file them in the <a href="https://github.com/o2r-project/erc-spec/issues">issue tracker</a>. If you have explicit changes please fork the <a href="https://github.com/o2r-project/erc-spec">git repo</a> and submit a pull request.
</div>

## Version

The version of this specification is `1`.
This version is _under development_!

## Table of contents

- [Introduction](index.md)
    - [Notational conventions](#notational-conventions)
    - [Purpose](#purpose)
    - [Fundamental concepts](#fundamental-concepts)
- [Structure](#erc-structure)
- [Security](#security)
- Extensions
    - [Docker runtime extension](docker.md)
    - [Archival extension](archival.md)
    - [R extension](r.md)
    - [Validation extension](valid.md)
- Extensions - _Drafts and Ideas_
    - [Plain R runtime extension](plain_r.md)
    - [Manipulation extension](man.md)
    - [Progress extension](progress.md)
    - [Container bundling extension](bundle_container.md)
- [Glossary](glossary.md)

## Notational conventions

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" are to be interpreted as described in [RFC 2119][rfc2119].

The key words "unspecified", "undefined", and "implementation-defined" are to be interpreted as described in the [rationale for the C99 standard][c99-unspecified].

## Purpose

This specification defines a structure to carry and execute a computational scientific analyses (cf. [computational science](https://en.wikipedia.org/wiki/Computational_science).

These analyses typically comprise a workspace on a researchers computer, which comprises data, code, third party software or libraries, and outputs such as plots.
Code and libraries are required in executable form to re-do an analysis.
Putting all of this elements in a self-contained bundle allows to transfer, archive, reproduce, and validate computaional research.

## Fundamental design concepts

The bagtainer specification is inspired by two approaches to improve development and operation of software.
First,  [_"convention  over  configuration"_](https://en.wikipedia.org/wiki/Convention_over_configuration), e.g. as  practiced  in  the Java build tool [Maven](https://books.sonatype.com/mvnref-book/reference/installation-sect-conventionConfiguration.html).
Second, _"DevOps"_, see [Wikipedia](https://en.wikipedia.org/wiki/DevOps) or [Boettiger](https://doi.org/10.1145/2723872.2723882).

Another core goal is _simplicity_.
This specification should not re-do something which already exists (if it is an open specification or tool).
It must be possible to create a valid and working ERC manually.

The final important notion is the one of _nested containers_.
Acknowledging well defined standards exist for packaging a set of files, and different approaches to create an executable code package are possible, the collection of files which make up an ERC comprise _one or more containers but are themselves subject to being put into a container_.
We distinguish these containers into the inner or "runtime" container and the outer container.

## How to use an ERC

The steps to (re-)run the analysis contained in an ERC are as follows:

- (if compressed first extract then) open the ERC
- execute the container
- compare the output contained in the bag with the just created new output

This way ERC allow computational reproducibility based on the original code and data.

## ERC structure

### Base directory

An ERC MUST have a _base directory_. The name of the base directory MUST only contain characters, numbers, `_` (underscore) and `-` (minus sign).
That directory is part of the [bundle](https://github.com/opencontainers/runtime-spec/blob/master/bundle.md).
In other words, an archive of an ERC will have one top-level directory with the name of the base directory.

**Regular expression** for base directory name: `[a-zA-Z0-9\-_]`

The base directory MUST contain an [ERC configuration file](#erc-configuration-file).

Besides the files mentioned in this specification, the base directory may contain any other file and directories.

### Main file

An ERC MUST have a _main document_, i.e. the file which contains the text and instructions being the basis for the scientific publication describing the packaged analysis.
The main documents name SHOULD be `paper` with an appropriate extension, e.g. `.tex`.

### Display file

An ERC MUST have a _display file_, i.e. the file which is shown to the user first when he opens an ERC in a supporting platform or tool.
The display file SHOULD be named `paper` with an appropriate extension, e.g. `.pdf` or `.html`.

## Nested runtime

The embedding of a representation of the original runtime environment, in which an analysis was conducted, is crucial for supporting reproducible computations.
This section defines two such representations, one documenting and one executable. 

The format of these representations is undefined and SHOULD be stated more precisely in an extension.

A concrete runtime extension may choose to embed the runtime environment or to rely on constructing it from the manifest.

### Runtime environment or image

The base directory SHOULD contain a runnable image, e.g. a binary, of the original analysis environment that can be used to re-run the packaged analysis.

The file SHOULD be named `image` with an appropriate extension, such as `.tar` or `.bin`.

The output of the image execution can be shown to the user to convey detailed information on progress or errors.

### Runtime manifest

The base directory MUST contain a complete, self-consistent manifest of the runtime image's contents.

This manifest MUST be in a machine-readable format that allows a respective tool to create the runtime image.

A concrete runtime extension MUST define the command to create the runnable environment from the manifest.

### Runtime manipulation

Bundline a complete runtime gives the possibility to manipulate the contained workflow or exchange data.

The manipulation parameters SHOULD be defined in a concrete runtime extension.

The data replacement proccess SHOULD be define in a concrete runtime extension.

## ERC configuration file

The ERC configuration file is the _reproducibility manifest_ for an ERC. It defines the main entry points for actions performed on an ERC and core metadata elements.

### Name, format, and encoding

The filename MUST be `erc.yml` and it MUST be located in the base directory.
The contents MUST be valid [YAML 1.2](http://yaml.org/).
The file MUST be encoded in `UTF-8` and MUST NOT contain a byte-order mark (BOM).

### Required fields

The first document content of this file MUST contain the following string nodes at the root level.

- `spec_version`: a text string noting the version of the used ERC specification. The appropriate version for an ERC conforming to this version of the specification is `1`.
- `id`: globally unique identifier for a specific ERC. This SHOULD be a URI (see [rfc3986][rfc3986]) or a [UUID][uuid], Version 4.

[//]: # (could use semantic versioning later)

Minimal example:

```yml
id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
spec_version: 1
```

The main and display file can be defined in root-level nodes named `main` and `display` respectively:

```yml
id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
spec_version: 1
main: the_paper_document.odt
display: output.html
```

### Control statements

The configuration file MUST contain [bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) statements to control the runtime container.

These statements MUST be in an array under the node `command` under the root-level node `execution` in the ERC configuration file.

Default command statements SCHOULD be defined by an extension for a working ERC.

The exectution statements SHOULD ensure, that the re-computation is independent from the environment that may be different depending on the host.
This includes, for example, setting the time zone via an environment variable `-e TZ=CET` so that output formatting of timestamps does not break validation.
This can also be handled by the ERC author on script level.

Example control statements:

```yml
id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
spec_version: 1
execution:
  command:
    - `./prepare.sh --input my_data`
    - `./execute.sh --output results --iterations 3`
```

### Discovery metadata

author
title
description
. . .

_The discovery metadata MUST be compliant to the o2r-metadata schema._

### License metadata

`erc.yml` MUST contain a first level node `licenses` with licensing information for the code, data, and text contained.
Each of these three have distinct requirements, hence different licenses need to be applied.

The node `licenses` MUST have three children: `code`, `data`, `text`.

<div class="alert note" markdown="block">
There is currently no mechanism to define the licenses of the used libraries, as manual creation would be tedious.
Tools for automatic creation of ERC may add such detailed licensing information and define an extension to the ERC 
</div>

The content of each of these child nodes MUST be one of the following

- text string with license identifier or license text. This SHOULD be a standardized identifier of an existing license as defined by the [Open Definition Licenses Service](http://licenses.opendefinition.org/).
- a dictionary of all files or directories and their respective license, each of the values following the previous statement. The node values are the file paths relative to the base directory.

Example for global licenses:

```yml
id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
spec_version: 1
licenses:
  code: "Apache-2.0"
  data: "ODbL-1.0"
  text: "CC0-1.0"
```

Example using specific licenses for files:

```yml
---
id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
spec_version: 1
licenses:
  code:
    others_lib.bin: MIT
    my_code.c: GPL-3.0
  text:
    README.md: CC0-1.0
    paper/chapter01.doc: CC-BY-4.0
    paper/chapter02.tex: CC-BY-4.0
```

<div class="alert note" markdown="block">
It IS NOT possible to assign one license to a directory and override that assignment or a single file within that directory, NOR IS it possible to use globs or regular expressions.
</div>

### Software metadata

An ERC SHOULD provide a machine readable list of software that is contained.
This list can have different formats for different use cases or depending on the source of information, which is probably a tool rather than manual creation.
The information can also be quite extensive.

Therefore this information MUST NOT be included in the ERC configuration file but SHOULD be referenced from there to support implementing tools.

The software metadata documents, if present, MUST be listed as paths relative to the base directory.

Information on the format of the files SHOULD be conveyed to both human and machine users based on file name and file extension.

Further details are unspecified here but could be defined in specification extensions.

```yml
---
id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
spec_version: 1
metadata:
  software:
    - .erc/software_codemeta.json
    - dpkg--list.txt
```

### Extension metadata

If an extension of the specification is used, it MUST be put into a list under the root-level node `extensions`.

```yml
---
id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
spec_version: 1
extensions:
  - extension_name_1
  - "yet another extension"
```

This list SHOULD be used by implementations that support these extensions to comply with validation checks or processes as defined by the extensions.

If an implementation encounters an unsupported extension it MUST issue a user level warning.

If an implementation supports an extension it MUST use default settings, for example for control commands, as defined in the extension.

If an extension creates additional (custom) metadata fields, they MUST NOT interfere with the structure defined in this document.
However, it is unspecified into which root node or nodes of the ERC configuration file these metadata should go.

## .ercignore file

The ERC MAY contain a file named `.ercignore` in the base directory.
If this file is present, any files and directories matching the patterns within that file will be excluded from processes such as validation.
The newline-separated patterns in the file will be treated as [Unix shell globs](https://en.wikipedia.org/wiki/Glob_(programming)).

Tools implementing this specification SHOULD communicate the names of ignored files or directories to the user for a transparent validation procedure.

[//]: # (TODO: mention library used in reference implementation)

## Validation

ERC validation comprises four steps:

1. checking required metadata elements
1. executing the runtime container
1. comparing the results of the runtime container execution with the original files
1. running checks of used extensions

The comparison step SHOULD be based on `md5` checksums and compare recursively all files that are _reasonable to hash as a comparison_.

The validation MUST NOT fail when files listed in `.ercignore` are failing comparison.

The following [media types](https://en.wikipedia.org/wiki/Media_type) are a regular expressions of file formats that SHALL be used (unless ignored) for comparison:

- `text/*`
- `application/json`
- `*+xml`
- `*+json`

See [IANA's full list of media types](https://www.iana.org/assignments/media-types/media-types.xhtml).

The validation SHOULD communicate all files and directories used for validation to the user to avoid malicious usage of an `.ercignore` file.

## Security considerations

Why are ERC not a security risk?

[//]: # (take a look at https://tools.ietf.org/html/draft-kunze-bagit-14#section-6)

- the spec prohibits use of `EXPOSE`
- the containers are only executed _without_ external network access using `Network: none`, see [Docker CLI run documentation](https://docs.docker.com/engine/reference/run/#/network-none)

## Secondary metadata files

An ERC can be an object in several use cases.
For example, it can be an item under review during a journal publication, it can be the actual publication at a workshop or conference, it can be a preserved item in a research repository.
All of these probably have their own standards and requirements when it comes to metadata.
These metadata requirements are _not_ part of this specification, but the following conventions should simplify their (re-)use.

Domain or use case specific metadata SHOULD replicate all and only the information required for the specific case.

Metadata documents of specific use cases SHOULD be stored in a directory `.erc` in the base directory.

They SHOULD be named according to the used standard or platform, and the used format, e.g. `datacite.xml` or `zenodo_sandbox.json`.

## Comprehensive example of erc.yml

The following example shows all possible fields and their default values of the core specification.

```yml
id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
spec_version: 1
structure:
  payload_directory: "data"
  config_file: "erc.yml"
  container_file: "image.tar"
  container_manifest: "Dockerfile"
execution:
  mountpoint: "/erc"
  command: "rmarkdown::render(input = 'paper.Rmd', output_format = )"
licenses:
  ...
```


[c99-unspecified]: http://www.open-std.org/jtc1/sc22/wg14/www/C99RationaleV5.10.pdf#page=18
[rfc2119]: http://tools.ietf.org/html/rfc2119
[issues]: https://github.com/o2r-project/erc-spec/issues
[repo]: https://github.com/o2r-project/erc-spec
[rfc3986]: https://tools.ietf.org/html/rfc3986
[uuid]: https://en.wikipedia.org/wiki/Universally_unique_identifier
