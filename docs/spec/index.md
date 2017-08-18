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
- [Glossary](glossary.md)

## Notational conventions

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" are to be interpreted as described in [RFC 2119][rfc2119].

The key words "unspecified", "undefined", and "implementation-defined" are to be interpreted as described in the [rationale for the C99 standard][c99-unspecified].

## Purpose

This specification defines a structure to carry and execute a computational scientific analyses (cf. [computational science](https://en.wikipedia.org/wiki/Computational_science)).
It carries technical and conceptual details on how to implement the reproducibility specifications and is as such most suitables for developers. Authors may feel more comfortable with the reference implementation of the ERC and the manual provided in the user guide.

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
It must be possible to create a valid and working ERC _manually_.

The final important notion is the one of _nested containers_.
We acknowledge well defined standards for packaging a set of files, and different approaches to create an executable code package.
Therefore an ERC comprises _one or more containers but is itself subject to being put into a container_.
We distinguish these containers into the inner or "runtime" container and the outer container, which is used for transfer of complete ERC and not content-aware validation.

Finally, this specification may be extended or limited further by so called _extensions_.
Extensions MAY add any additional structure to an ERC or change defaults.
But they MUST NOT interfere with this specification, e.g. by changing the meaning of a configuration field.

## How to use an ERC

The steps to (re-)run the analysis contained in an ERC are as follows:

- (if compressed first extract then) unpack the ERC's outer container
- execute the runtime container
- compare the output files contained in the outer container with the just output files just created by the runtime container

This way ERC allow computational reproducibility based on the original code and data.

## ERC structure

### Base directory

An ERC MUST has a _base directory_. All paths within this document are relative to this base directory.

The base directory MUST contain an [ERC configuration file](#erc-configuration-file).

Besides the files mentioned in this specification, the base directory MAY contain any other files and directories.

### Main document & display file

An ERC MUST have a _main document_, i.e. the file which contains the text and instructions being the basis for the scientific publication describing the packaged analysis.

The main document's name SHOULD be `main` with an appropriate file extension and media type.
For example if the main document is RMarkdown, then the file extension should be `.Rmd` and the media type `text/markdown`.

An ERC MUST have a _display file_, i.e. the file which is shown to the user first when he opens an ERC in a supporting platform or tool.

The display file's name SHOULD be `view` with an appropriate file extension and media type.
For example if the main document is Hypertext Markup Language (HTML), then the file extension should be `.htm` or `.html` and the media type `text/html`.

<div class="alert note" markdown="block">
Typically, the _display file_ is "rendered" from the main file, which follows the [literate programming paradigm](https://en.wikipedia.org/wiki/Literate_programming).
</div>

## Nested runtime

The embedding of a representation of the original runtime environment, in which an analysis was conducted, is crucial for supporting reproducible computations.
This section defines two such representations.
First, an executable image.
Second, a manifest documenting the image's contents.

The format of these representations is undefined here and can be stated more precisely in an extension to this specification.

<div class="alert note" markdown="block">
A concrete runtime extension may choose to (a) embed the runtime environment in the image, or (b) to rely on constructing the runtime environment from the manifest.
</div>

### Runtime environment or image

The base directory SHOULD contain a runnable image, e.g. a "binary", of the original analysis environment that can be used to re-run the packaged analysis using a suitable software.

The image file MAY be compressed.
It SHOULD be named `image` with an appropriate file extension, such as `.tar`, `tar.gz` or `.bin`, and have an appropriate mime type, e.g. `application/vnd.oci.image.layer.tar+gzip`.

The name of the image file MUST be given in the ERC configuration file under the node `image` under the root-level node `execution`.

The output of the image execution can be shown to the user to convey detailed information on progress or errors.

### Runtime manifest

The base directory MUST contain a complete, self-consistent manifest of the runtime image's contents.

This manifest MUST be in a machine-readable format that allows a respective tool to create the runtime image.

The name of the manifest file MUST be given in the ERC configuration file under the node `manifest` under the root-level node `execution`.

## ERC configuration file

The ERC configuration file is the _reproducibility manifest_ for an ERC. It defines the main entry points for actions performed on an ERC and core metadata elements.

### Name, format, and encoding

The filename MUST be `erc.yml` and it MUST be located in the base directory.
The contents MUST be valid [YAML 1.2](http://yaml.org/).
The file MUST be encoded in `UTF-8` and MUST NOT contain a byte-order mark (BOM).

### Basic fields

The first document content of this file MUST contain the following string nodes at the root level.

- `spec_version`: a text string noting the version of the used ERC specification. The appropriate version for an ERC conforming to this version of the specification is `1`.
- `id`: globally unique identifier for a specific ERC. This SHOULD be a URI (see [rfc3986][rfc3986]) or a [UUID][uuid], Version 4.

[//]: # (could use semantic versioning later)

Example:

```yml
id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
spec_version: 1
```

The main and display file can be defined in root-level nodes named `main` and `display` respectively:

```yml
id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
spec_version: 1
main: the_paper_document.rmd
display: view.html
```

### Control statements

The configuration file MUST contain statements to control the runtime container.

These statements MUST be in an array under the root-level node `execution` in the ERC configuration file in the order in which they must be executed.

Implementations SHOULD support a list of [bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) commands as control statements.
These commands are given as a list under the node `cmd` under the root-level node `execution`.
If extensions use non-bash commands, they MUST define own nodes under the `execution` node and SHOULD define defaults.

The execution statements MAY ensure the re-computation being independent from the environment, which may be different depending on the host of the execution environment.
For example, the time zone could be fixed via an environment variable `TZ=CET`, so output formatting of timestamps does not break checking.
This is in addition to ERC authors handling such parameters at a script level.

Example control statements:

```yml
id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
spec_version: 1
execution:
  cmd:
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
  data: 
	facts.csv: ODbL-1.0
  text:
    README.md: CC0-1.0
    paper/chapter01.doc: CC-BY-4.0
    paper/chapter02.tex: CC-BY-4.0

```

<div class="alert note" markdown="block">
It IS NOT possible to assign one license to a directory and override that assignment or a single file within that directory, NOR IS it possible to use globs or regular expressions.
</div>

## Comprehensive example of erc.yml

The following example shows all possible fields of the core specification with example values.

```yml
id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
spec_version: 1
main: the_paper_document.rmd
display: view.html
execution:
  cmd: "Rscript -e 'rmarkdown::render(input = \"paper.Rmd\", output_format = \"html\")'"
licenses: # licenses that the author chooses for their files
  code:
    others_lib.bin: MIT
    my_code.c: GPL-3.0
  data:
	facts.csv: ODbL-1.0
  text:
    README.md: CC0-1.0
    paper/chapter01.doc: CC-BY-4.0
    paper/chapter02.tex: CC-BY-4.0
```

The path to the ERC configuration file subsequently MUST be `<path-to-bag>/data/erc.yml`.


## Content metadata

### Metadata elements _under development_

Current JSON dummy to visualise the properties. It SHOULD be filled out as good as possible.

```json
{
	"access_right": "open",
	"author": [{
		"name": null,
		"affiliation": [],
		"orcid": null
	}],
	"codefiles": [],
	"community": "o2r",
	"depends": [{
		"identifier": null,
		"version": null,
		"packageSystem": null
	}],
	"description": null,
	"ercIdentifier": null,
	"file": {
		"filename": null,
		"filepath": null,
		"mimetype": null
	},
	"generatedBy": null,
    "identifier": {
        "doi": null,
        "doiurl": null,
        "reserveddoi": null
    },
    "inputfiles": [],
    "interaction": {
        "interactive": false,
    "ui_binding": {
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
	"title": null,
    "upload_type": "publication",
    "viewfile": []
}
```

The path to the o2r metadata file MUST be `<path-to-bag>/data/metadata.json`.

### Description of metadata properties

Defining explanations on the concept of each metadata element in use.

+ `access_right` Modify embargo status, default is `open`.
+ `author` Contains a list of authors, each containing author related information.
+ `author.affiliation` A list of institutions, organizations or other groups that the creator of the asset is associated with.
+ `author.name` The name of the human individual, institution, organization, machine or other entity that acts as creator of the asset.
+ `author.orcid` The ORCid of the creator of the asset.
+ `codefiles` A list of files, containing programm code (i.e. script files, e.g. .R files) retrieved during the extraction.
+ `community` Indicates belonging to a scientific community, e.g. on a repositoy platform.
+ `depends` A block for each entity that the software is directly dependent on for execution. The dependency information is designed for the identification of dependent packages within packaging systems. A depends block may describe a transitive dependency.
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
+ `identifier` Contains information related to persitent identifiers for the asset.
+ `identifier.doi` The DOI for the asset.
+ `identifier.doiurl` The resolving URL for the asset.
+ `identifier.reserveddoi` The assigned but inactive DOI for the asset. Might be minted by a repository during publication.
+ `inputfiles` A list of files that are loaded as resources by the main or code files of a workspace.
+ `interaction` Information on interactive elements in the asset.
+ `interaction.interactive` 'TRUE' if interactive elements are already included, otherwise 'FALSE'.
+ `interaction.ui_binding` A block for each UI binding - extends a figure by a UI widget, e.g. for manipulation. Final structure depends on purpose.
+ `interaction.ui_binding.purpose` What the UI binding is supposed to do.
+ `interaction.ui_binding.widget` Which UI widget realizes the purpose.
+ `interaction.ui_binding.code` A block containing source-code-specific information required to realize the UI binding.
+ `interaction.ui_binding.code.filename` Name of the file including the plot function that creates the figure.
+ `interaction.ui_binding.code.function` Name of the function that plots the figure.
+ `interaction.ui_binding.code.functionParameter` Parameters required by the shinyInputFunction. Final set of parameters depends on UI widget.
+ `interaction.ui_binding.variable` Variable that should be controlled by the UI widget.
+ `interaction.ui_binding.code.shinyInputFunction` Function that incorporates the UI widgets, provided by Shiny. 
+ `interaction.ui_binding.code.shinyRenderFunction` Function that renders the plot after each change, provided by Shiny.
+ `keywords` Tags associated with the asset.
+ `license` License information for the entire ERC.
+ `paperLanguage` A list of language codes that indicate the language of the asset, e.g. _en_.
+ `paperSource` The text document file of the paper.
+ `publicationDate` The publication date of the paper publication as [ISO8601](https://en.wikipedia.org/wiki/ISO_8601) string.
+ `publication_type` The type of the publication. Default is `other` since the ERC may contain text, data, code and interaction widgets not depictable by other categories.
+ `recordDateCreated` The date that this metadata record was created as [ISO8601](https://en.wikipedia.org/wiki/ISO_8601) string.
+ `softwarePaperCitation` Related citation information for the asset, e.g. a citation of the related journal article.
+ `spatial` Information about the geometric bounding box of the underlying data/software.
+ `spatial.files` A Geojson object of the file-wise bounding boxes of the underlying data/software.
+ `spatial.union` A Geojson object displaying the spatial properties, e.g. a bounding box of the whole data.
+ `temporal` Aggregated information about the relevant time period of the underlying data sets.
+ `temporal.begin` The starting point of the relevant time period.
+ `temporal.end` The end point of the relevant time period.
+ `title` The distinguishing name of the paper publication.
+ `upload_type` The zenodo upload type, default is `publication`. This element will be removed, once the target repository is completely configurabe within the o2r shipper micro service.
+ `view_file` The main display file.

## ERC checking

### Procedure

A core feature of ERCs is to compare the output of an ERC executions with the original outpts.
Therefore checking an ERC always comprises two core steps: the execution and the comparison.

The method of the comparison is unspecified.
The files included in the comparison are the _comparison set_.
An implementation MUST communicate the comparison set to the user as part of a check.

### Comparison set file

The ERC MAY contain a file named `.ercignore` in the base directory to define the comparison set.

Its purpose is to provide a way to efficiently exclude files and directories from checking.
If this file is present, any files and directories within the outer container which match the patterns within the file `.ercignore` will be excluded from the checking process.
The check MUST NOT fail when files listed in `.ercignore` are failing comparison.

The file MUST be UTF-8 (without BOM) encoded.
The newline-separated patterns in the file MUST be [Unix shell globs](https://en.wikipedia.org/wiki/Glob_(programming)).
For the purposes of matching, the root of the context is the ERC's base directory.

Lines starting with `#` are treated as comments and MUST be ignored by implementations.

Example `.ercignore` file:

```
# comment
.erc
*/temp*
data-old/*
```

<div class="alert note" markdown="block">
If using [md5]() files hashes for comparison, the set could include plain text files, for example the `text/*` [media types](https://en.wikipedia.org/wiki/Media_type) (see [IANA's full list of media types](https://www.iana.org/assignments/media-types/media-types.xhtml). Of course the comparison set should include files which contain results of an analysis.
</div>

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
