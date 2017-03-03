# ERC specification

An Exectuable Research Compendium (ERC) is a packaging convention for computational research.
It provides a well-defined structure for data, code, text, documentation, and user interface controls for a piece of research and is suitable for long-term archival. As such it can also be perceived as a digital object or asset.

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

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "



", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" are to be interpreted as described in [RFC 2119][rfc2119].

The key words "unspecified", "undefined", and "implementation-defined" are to be interpreted as described in the [rationale for the C99 standard][c99-unspecified].

## Purpose

This specification defines a structure to carry and execute a computational scientific analyses (cf. [computational science](https://en.wikipedia.org/wiki/Computational_science)).

These analyses typically comprise a workspace on a researcher's computer, which comprises _data_, _code_, third party software or libraries, and outputs such as plots.
Code and libraries are required in executable form to re-do an analysis.
Research is only put into a context by a _textual_ publication, which is published in [scholarly communication](https://en.wikipedia.org/wiki/Scholarly_communication).
The text comes in two forms: one that is machine readable, and another one that is suitable for being read by humans.
The latter is often derived, or "rendered", from the former and can be static, visual, or even interactive.

Putting all of this elements in a self-contained bundle allows understanding, reproducing, transferring, archiving, and validating computational research.
The ERC specification defines metadata and file structures to support these actions.

## Fundamental design concepts

The ERC specification is inspired by two approaches to improve development and operation of software.
First,  [_"convention  over  configuration"_](https://en.wikipedia.org/wiki/Convention_over_configuration), e.g. as  practiced  in  the Java build tool [Maven](https://books.sonatype.com/mvnref-book/reference/installation-sect-conventionConfiguration.html).
Second, _"DevOps"_, see [Wikipedia](https://en.wikipedia.org/wiki/DevOps) or [Boettiger](https://doi.org/10.1145/2723872.2723882).

Another core goal is _simplicity_.
This specification should not re-do something which already exists (if it is an open specification or tool).
It must be possible to create a valid and working ERC manually.

The final important notion is the one of _nested containers_.
We acknowledge well defined standards for packaging a set of files, and different approaches to create an executable code package.
Therefore an ERC comprises _one or more containers but is itself subject to being put into a container_.
We distinguish these containers into the inner or "runtime" container and the outer container, which is used for transfer of complete ERC and not content-aware validation

## How to use an ERC

The steps to (re-)run the analysis contained in an ERC are as follows:

- (if compressed first extract then) unpack the ERC's outer container
- execute the runtime container
- compare the output files contained in the outer container with the just output files just created by the runtime container

This way ERC allow computational reproducibility based on the original code and data.

## ERC structure

### Base directory

An ERC MUST have a _base directory_. The name of the base directory MUST only contain characters, numbers, `_` (underscore) and `-` (minus sign).
That directory is part of the [bundle](https://github.com/opencontainers/runtime-spec/blob/master/bundle.md).
In other words, an archive of an ERC will have one top-level directory with the name of the base directory.

**Regular expression** for base directory name: `[a-zA-Z0-9\-_]`

The base directory MUST contain an [ERC configuration file](#erc-configuration-file).

Besides the files mentioned in this specification, the base directory may contain any other files and directories.

### Main document & display file

An ERC MUST have a _main document_, i.e. the file which contains the text and instructions being the basis for the scientific publication describing the packaged analysis.
The main document's name SHOULD be `main` with an appropriate extension and media type.
For example if the main document is RMarkdown, then the extension should be `.Rmd` and the media type `text/markdown`.

An ERC MUST have a _display file_, i.e. the file which is shown to the user first when he opens an ERC in a supporting platform or tool.
The display file's name SHOULD be `view` with an appropriate extension and media type.
For example if the main document is Hypertext Markup Language (HTML), then the extension should be `.htm` or `.html` and the media type `text/html`.

The display file is often "rendered" from the main file.

## Nested runtime

The embedding of a representation of the original runtime environment, in which an analysis was conducted, is crucial for supporting reproducible computations.
This section defines two such representations.
First, an executable image.
Second, a manifest documenting the image's contents.

The format of these representations is undefined here and can be stated more precisely in an extension to this specification.

A concrete runtime extension may choose to (a) embed the runtime environment in the image, or (b) to rely on constructing the runtime environment from the manifest.

### Runtime environment or image

The base directory SHOULD contain a runnable image, e.g. a "binary", of the original analysis environment that can be used to re-run the packaged analysis using a suitable software.

The image file may be compressed.
It SHOULD be named `image` with an appropriate extension, such as `.tar` or `.bin`, and have an appropriate mime type, e.g. `application/vnd.oci.image.layer.tar+gzip`.

The output of the image execution can be shown to the user to convey detailed information on progress or errors.

### Runtime manifest

The base directory MUST contain a complete, self-consistent manifest of the runtime image's contents.

This manifest MUST be in a machine-readable format that allows a respective tool to create the runtime image.

A concrete runtime extension MUST define the command to create the runnable environment from the manifest.

<!--### Runtime manipulation

Bundling a complete runtime gives the possibility to manipulate the contained workflow or exchange data.

The manipulation parameters SHOULD be defined in a concrete runtime extension.

The data replacement proccess SHOULD be defined in a concrete runtime extension.
-->
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

Default command statements SHOULD be defined by an extension for a working ERC.

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


### License metadata

The file `erc.yml` MUST contain a first level node `licenses` with licensing information for the code, data, and text contained.
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
  code: Apache-2.0
  data: ODbL-1.0
  text: CC0-1.0
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

## Comprehensive example of erc.yml

The following example shows all possible fields of the core specification with example values.

```yml
id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
spec_version: 1
structure:
  payload_directory: "data" # folder name including the workspace, after using bagger  
  config_file: "erc.yml"
  container_file: "image.tar"
  container_manifest: "Dockerfile"
execution:
  mountpoint: "/erc" # name of the volume used in the Dockerfile
  command: "Rscript -e 'rmarkdown::render(input = \"paper.Rmd\", output_format = \"html\")'"
licenses: # licenses that the author chooses for their files
  code:
    others_lib.bin: MIT
    my_code.c: GPL-3.0
  text:
    README.md: CC0-1.0
    paper/chapter01.doc: CC-BY-4.0
    paper/chapter02.tex: CC-BY-4.0
extensions:
  - extension_name_1
  - "yet another extension"
```

The path to the ERC configuration file subsequently MUST be `<path-to-bag>/data/erc.yml`.



## .ercignore file

The ERC MAY contain a file named `.ercignore` in the base directory.
If this file is present, any files and directories within the outer container which match the patterns within the file `.ercignore` will be excluded from the validation process.
The newline-separated patterns in the file MUST be [Unix shell globs](https://en.wikipedia.org/wiki/Glob_(programming)).

The following [media types](https://en.wikipedia.org/wiki/Media_type) (see [IANA's full list of media types](https://www.iana.org/assignments/media-types/media-types.xhtml)) are regular expressions of file formats that CAN be used:

- `text/*`
- `application/json`
- `*+xml`
- `*+json`

## Content metadata

### Metadata elements _under development_

Current JSON dummy to visualise the properties. It SHOULD be filled out as good as possible.

```json
{
	"author": [{
		"name": null,
		"affiliation": [],
		"orcid": null
	}],
	"community": "o2r",
	"depends": [{
		"identifier": null,
		"version": null,
		"packageSystem": null,
	}],
	"description": null,
	"ercIdentifier": null,
	"file": {
		"filename": null,
		"filepath": null,
		"mimetype": null
	},
	"generatedBy": null,
    "interaction": {
        "interactive": false,
	{
	"purpose": null,
	"widget": null,
	"code": {
		"filename": null,
		"function": null,
		"variable": null,
		"shinyInputFunction": null,
		"shinyRenderFunction": null,
		"functionParameter": {
			"name": null,
			"label": null,
			"min": null,
			"max": null,
			"value": null,
			"step": null
			}
		}
	}
    },
	"keywords": [],
	"license": null,
	"paperLanguage": [],
	"paperSource": null,
	"publicationDate": null,
	"recordDateCreated": null,
	"softwarePaperCitation": null,
	"spatial": {
		"files": [],
		"union": []
	},
	"temporal": {
		"begin": null,
		"end": null
	},
	"title": null
}
```

The path to the o2r metadata file MUST be `<path-to-bag>/data/metadata.json`.

### Description of metadata properties

Defining explanations on the concept of each metadata element in use.

+ `author` Contains a list of author related information.
+ `author.affiliation` A list of institutions, organizations or other groups that the creator of the asset is associated with.
+ `author.name` The name of the human individual, institution, organization, machine or other entity that acts as creator of the asset.
+ `author.orcid` The ORCid of the creator of the asset.
+ `community` Indicates belonging to a scientific community, e.g. on a repositoy platform.
+ `depends` A block for each entity that the software is dependent on for execution.
+ `depends.identifier` An identifying name for the depending package.
+ `depends.version` The computer software and hardware required to run the software.
+ `depends.packageSystem` The package manager system that makes the dependency entity available.
+ `description` A text representation conveying the purpose and scope of the asset (the abstract).
+ `ercIdentifier` A universally unique character string associated with the asset as _executable research compendium_, provided by the o2r service.
+ `file` A block for the main source file for the metadata (e.g. rmd file), generated and used by the o2r service.
+ `file.filename` See above 
+ `file.filepath` See above 
+ `file.mimetype` See above 
+ `generatedBy` The entity, person or tool, that created the software.
+ `interaction` Information on interactive elements in the asset.
+ `interaction.interactive` 'TRUE' if interactive elements are already included, otherwise 'FALSE'.
+ `interaction.ui_binding` A block for each UI binding - extends a figure by a UI widget, e.g. for manipulation. Final structure depends on purpose.
+ `interaction.ui_binding.purpose` What the UI binding is supposed to do.
+ `interaction.ui_binding.widget` Which UI widget realizes the purpose.
+ `interaction.ui_binding.code` A block containing source-code-specific information required to realize the UI binding.
+ `interaction.ui_binding.code.filename` Name of the file including the plot function that creates the figure.
+ `interaction.ui_binding.code.function` Name of the function that plots the figure.
+ `interaction.ui_binding.variable` Variable that should be controlled by the UI widget.
+ `interaction.ui_binding.code.shinyInputFunction` Function that incorporates the UI widgets, provided by Shiny. 
+ `interaction.ui_binding.code.shinyRenderFunction` Function that renders the plot after each change, provided by Shiny.
+ `interaction.ui_binding.code.functionParameter` Parameters required by the shinyInputFunction. Final set of parameters depends on UI widget.
+ `keywords` Tags associated with the asset.
+ `license` License information for the entire ERC.
+ `paperLanguage` A list of language codes that indicate the language of the asset, e.g. _en_.
+ `paperSource` The text document file of the paper.
+ `publicationDate` The publication date of the paper publication.
+ `recordDateCreated` The date that this metadata record was created.
+ `softwarePaperCitation` A text string that can be used to authoritatively cite a research paper, conference proceedings or other scholarly work that describes the design, development, usage, significance or other aspect of the software.
+ `spatial` Information about the geometric bounding box of the underlying data/software.
+ `spatial.files` A Geojson object of the aggregated bounding boxes of the underlying data/software, generated by the o2r service.
+ `spatial.union` A Geojson object displaying the spatial properties of the data.
+ `temporal` Aggregated information about the relevant time period of the underlying data sets.
+ `temporal.begin` The starting point of the relevant time period.
+ `temporal.end` The end point of the relevant time period.
+ `title` The distinguishing name of the paper publication.


## Validation

ERC validation comprises four steps:

1. checking required metadata elements
1. executing the runtime container
1. comparing the output files of the runtime container execution with the original output files in the outer container
<!-- 1. running checks of active extensions -->

<!--The comparison step (`3.`) SHOULD be based on `md5` checksums and compare recursively all files that are _reasonable to compare with hashes_, for example text-based documents but not compressed pictures.-->

The validation MUST NOT fail when files listed in `.ercignore` are failing comparison.

The validation SHOULD communicate all files and directories actually used for validation to the user to avoid malicious usage of an `.ercignore` file.

<!-- Tools implementing this specification SHOULD communicate the names of ignored files or directories to the user for a transparent validation procedure. -->

## Security considerations

Why are ERC not a security risk?

[//]: # (take a look at https://tools.ietf.org/html/draft-kunze-bagit-14#section-6)

- the spec prohibits use of `EXPOSE`
- the containers are only executed _without_ external network access using `Network: none`, see [Docker CLI run documentation](https://docs.docker.com/engine/reference/run/#/network-none)

<!-- Prefer checksums from cryptographic hash functions that have not yet been broken by collisions. -->

[c99-unspecified]: http://www.open-std.org/jtc1/sc22/wg14/www/C99RationaleV5.10.pdf#page=18
[rfc2119]: http://tools.ietf.org/html/rfc2119
[issues]: https://github.com/o2r-project/erc-spec/issues
[repo]: https://github.com/o2r-project/erc-spec
[rfc3986]: https://tools.ietf.org/html/rfc3986
[uuid]: https://en.wikipedia.org/wiki/Universally_unique_identifier
