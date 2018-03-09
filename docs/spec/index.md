\newpage
# ERC specification

An Executable Research Compendium (ERC) is a packaging convention for computational research.
It provides a well-defined structure for data, code, text, documentation, and user interface controls for a piece of research and is suitable for long-term archival. As such it can also be perceived as a digital object or asset.

!!! note
    This is a draft specification. If you have comments or suggestions please file them in the <a href="https://github.com/o2r-project/erc-spec/issues">issue tracker</a>. If you have explicit changes please fork the <a href="https://github.com/o2r-project/erc-spec">git repo</a> and submit a pull request.

## Preface

### Version

Specification version: **`1`**

!!! warning
    This version is _under development_!

### Notational conventions

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" are to be interpreted as described in [RFC 2119][rfc2119].

The key words "unspecified", "undefined", and "implementation-defined" are to be interpreted as described in the [rationale for the C99 standard][c99-unspecified].

### Purpose, target audience, and context

This specification defines a structure to transport and execute a computational scientific analysis (cf. [computational science](https://en.wikipedia.org/wiki/Computational_science)).
It carries technical and conceptual details on how to implement tools to enhance reproducibility and is most suitable **for developers**.
**Authors** may feel more comfortable with the _[user guides](/#user-guides)_.

These analyses typically comprise a digital workspace on a researcher's computer, which contains _data_ ([born digital](https://en.wikipedia.org/wiki/Born-digital), simulated, or other), _code_, third party _software_ or libraries, and _outputs_ of research such as digital plots or data.
Code and libraries are required in executable form to re-do a specific analysis or workflow.
Research is only put into a context by a _text_, e.g. a research paper, which is published in [scholarly communication](https://en.wikipedia.org/wiki/Scholarly_communication).
The text comes in two forms: one that is machine readable, and another one that is suitable for being viewed by humans.
The latter is derived, or "rendered", from the former.
The viewing experience can be static, textual, visual, or interactive.

Putting all of these elements in a self-contained bundle allows examining, reproducing, transferring, archiving, and formally validating computational research results in a time frame for peer review and collaboration.
The ERC specification defines metadata and file structures to support these actions.

### Major constituents

Three major constituents group possible user interactions with ERC.

Create
: [Creation](../glossary.md#create) is transforming a workspace with data, code and text into an ERC.

Examine
: [Examination](../glossary.md#examine) is evaluating ERC at different levels, from inspecting contents to creating derived analyses.

Discover
: [Discovery](../glossary.md#discover) is searching for content powered by ERC properties, such as text, content metadata, code metadata et cetera.

### Design goals

Simplicity
: This specification should not re-do something which already exists (if it is an open specification or tool).
It must be possible to create a valid and working ERC _manually_, while supporting tools should be able to cover typical use cases with minimal required input by a creating user.

Nested containers
: We acknowledge well defined standards for packaging a set of files, and different approaches to create an executable code package.
Therefore an ERC comprises _one or more containers but is itself subject to being put into a container_.
We distinguish these containers into the inner or "runtime" container and the outer container, which is used for transfer of complete ERC and not content-aware validation.

### How to use an ERC

The steps to (re-)run the analysis contained in an ERC as part of an [examination](../glossary.md#examine) are as follows:

- (if compressed first extract then) unpack the ERC's outer container
- execute the runtime container
- compare the output files contained in the outer container with the output files just created by the runtime container

This way an ERC allows computational reproducibility based on the original code and data.

## ERC structure

### Base directory

An ERC MUST has a _base directory_. All paths within this document are relative to this base directory.

The base directory MUST contain an [ERC configuration file](#erc-configuration-file).

Besides the files mentioned in this specification, the base directory MAY contain any other files and directories.

### Main & display file

An ERC MUST have a _main file, i.e. the file which contains the text and instructions being the basis for the scientific publication describing the packaged analysis.
An ERC MUST have a _display file_, i.e. the file which is shown to a user first when she opens an ERC in a supporting platform or tool.

_Main file_ and _display file_ MUST NOT be the same file.

The _main file_ MUST be _executable_ in the sense that a software reads it as the input of a process to create the _display file_.
The _main file_'s name SHOULD be `main` with an appropriate file extension and [media type](https://en.wikipedia.org/wiki/Media_type).

!!! note
    The _main file_ thus follows the [literate programming paradigm](https://en.wikipedia.org/wiki/Literate_programming).

!!! tip "Example"
    If the main file is an R Markdown document, then the file extension should be `.Rmd` and the media type `text/markdown`.
    A file `main.Rmd` will consequently be automatically identified by an implementation as the ERC's _main file_.

The display file's name SHOULD be `display` with an appropriate file extension and media type.

!!! tip "Example"
    If the display file is an Hypertext Markup Language (HTML) document, then the file extension should be `.htm` or `.html` and the media type `text/html`.
    A file `display.html` will consequently be automatically identified by an implementation as the ERC's _display file_.

The ERC MAY use an interactive document with interactive figures and control elements for the packaged computations as the _display file_.
The _interactive display file_ MUST have `HTML` format and SHOULD be valid [HTML5](https://www.w3.org/TR/html5/).

!!! tip "Example"
    Typical examples for the two core documents are R Markdown with HTML output (i.e. `main.Rmd` and `display.html`), or an `R` script creating a PNG file (i.e. `main.R` and `display.png`).

### Nested runtime

The embedding of a representation of the original runtime environment, in which the analysis was conducted, is crucial for supporting reproducible computations.
Every ERC MUST include two such such representations:

1. an **executable runtime image** of the original analysis environment for re-running the packaged analysis, and 
2. a **runtime manifest** documenting the image's contents as a complete, self-consistent recipe of the runtime image's contents which is a machine-readable format that allows a respective tool to create the runtime image.

The image MUST be stored as a file, e.g. a "binary" or "archive", in the ERC base directory.

The manifest MUST be stored as a text file in the ERC base directory.

**System environment**

The nested runtime encapsulates software, files, and configurations up to a specific level of abstraction.
It may not include a complete operating system, for example for better performance or security reasons.
While this information is included in the nested runtime, it MUST be accessible without executing the runtime.
Hard to obtain information SHOULD be replicated in the configuration file.

If the nested runtime does not include the operating system, then the configuration file MUST include the following data about the environment used to create the ERC:

- _architecture_
- _operating system_
- _kernel_ (if applicable)
- _runtime software version_

An implementation SHOULD notify the user if the provided system environment is incompatible with the implementations capabilities.

!!! tip
    A partially incompatible system environment, especially a different kernel version, may still produce the desired result, as breaking changes are very rare.
    An implementation may utilise [semantic versioning](https://semver.org/) to improve its compatibility tests.
    An incompatible operating system, e.g. `linux` vs. `windows`, and architecture, e.g. `amd64` or `arm/v7`, are likely to fail.

## ERC configuration file

The ERC configuration file is the _reproducibility manifest_ for an ERC. It defines the main entry points for actions performed on an ERC and core metadata elements.

### Name, format, and encoding

The filename MUST be `erc.yml` and it MUST be located in the base directory.
The contents MUST be valid [YAML 1.2](http://yaml.org/).
The file MUST be encoded in `UTF-8` and MUST NOT contain a byte-order mark (BOM).

### Basic fields

The first document content of this file MUST contain the following string nodes at the root level.

- `spec_version`: a text string noting the version of the used ERC specification. The appropriate version for an ERC conforming to this version of the specification is `1`.
- `id`: globally unique identifier for a specific ERC. `id` MUST not be empty and MUST only contain lowercase letters, uppercase letters, digits and single separators. Valid separators are period, underscore, or dash. A name component MUST NOT start or end with a separator. An implementation MAY introduce further restrictions on minimum and maximum length of identifiers.

!!! Note
    While URIs (see [rfc3986][rfc3986]) are very common identifiers, not all systems support them as identifiers.
    For example they cannot be used for Docker image names.
    A [UUID][uuid] is a valid `id`.
    A regular expression to validate identifiers is `/^[^-_.][a-zA-Z0-9._-]+[^-_.]$/`.

The main and display file MAY be defined in root-level nodes named `main` and `display` respectively.
If they are not defined and multiple documents use the name `main.[ext]` or `display.[ext]`, an implementation SHOULD use the first file in [alphabetical order](https://en.wikipedia.org/wiki/Alphabetical_order).

!!! tip "Example of ERC configuration file with user-defined main and display files"
    ```yml
    id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
    spec_version: 1
    main: workflow.Rmd
    display: paper.html
    ```

Additionally, related resources such as a related publication can be stated with the `relatedIdentifier` element field.
A related identifier SHOULD be a globally unique persistent identifier and SHOULD be a URI.

### Control statements

The configuration file SHOULD contain statements to control the execution of the runtime image.

These statements MUST be in an array under the root-level node `execution` in the ERC configuration file in the order in which they must be executed.

Implementations SHOULD support a list of [bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) commands as control statements.
These commands are given as a list under the node `cmd` under the root-level node `execution`.
Non-bash commands MUST be defined under own nodes under the `execution` node.
The current/working directory for these commands MUST be the [ERC base directory](#base-directory).

The execution statements MAY ensure the re-computation being independent from the environment, which may be different depending on the host of the execution environment.
For example, the time zone could be fixed via an environment variable `TZ=CET`, so output formatting of timestamps does not break [checking](../glossary.md#check).
This is in addition to ERC authors handling such parameters at a script level.

!!! tip "Examples for control statements"
    ```yml
    execution:
      cmd:
        - `./prepare.sh --input my_data`
        - `./execute.sh --output results --iterations 3`
    ```

    ```yml
    id: 12345
    execution:
      cmd: >-
        'docker run -it --rm --volume $(pwd):/erc --volume $(pwd)/other_data.csv:/erc/data.csv:ro erc:12345'
    ```

### License metadata

The file `erc.yml` MUST contain a first level node `licenses` with licensing information for contained artefacts.
Each of these artefacts, e.g. code or data, have distinct requirements so it must be possible to apply different licenses.

The node `licenses` MUST have five child nodes: `text`, `data`, `code`, `ui_bindings`, and `metadata`.

!!! note
    There is currently no mechanism to define the licenses of all the used libraries and software in a structured format.
    Manual creation would be tedious.
    Tools for automatic creation of ERC may add such detailed licensing information and define additional metadata elements.

The content of each of these child nodes MUST be a string with one of the following contents:

- _license identifier_ as defined by the [Open Definition Licenses Service](http://licenses.opendefinition.org/)
- _name of file_ with either documentation on licensing or a full license text

!!! tip "Example for common licenses"
    ```yml
    id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
    spec_version: 1
    licenses:
      code: Apache-2.0
      data: ODbL-1.0
      text: CC0-1.0
          ui_bindings: CC0-1.0
        metadata: CC0-1.0
    ```

!!! tip "Example for non-standard licenses"
    ```yml
    id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
    spec_version: 1
    licenses:
        code: Apache-2.0
        data: data-licenses.txt
        text: "Creative Commons Attribution 2.0 Generic (CC BY 2.0)"
        ui_bindings: CC0-1.0

### Comprehensive example of erc.yml

The following example shows all possible fields of the ERC specification with example values.

```yml
id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
spec_version: 1
main: paper.rmd
display: paper.html
execution:
  cmd: "Rscript -e 'rmarkdown::render(input = \"paper.Rmd\", output_format = \"html\")'"
licenses:
  code:
    others_lib.bin: MIT
    my_code.c: GPL-3.0
  data:
	facts.csv: ODbL-1.0
  text:
    README.md: CC0-1.0
    paper.Rmd: CC-BY-4.0
  ui_bindings: CC0-1.0
  metadata: CC0-1.0
structure:
  convention: https://github.com/ropensci/rrrpkg
ui_bindings:
  interactive: true
  bindings:
    - purpose: http://.../data-inspection
      widget: http://.../tabular-browser
      code: [...]
      data: [...]
      text: [...]
    - purpose: http://.../parameter-manipulation
      widget: http://.../dropdown
    ```

The path to the ERC configuration file subsequently MUST be `<path-to-bag>/data/erc.yml`.

## Docker runtime

The ERC uses [Docker](http://docker.com/) to define, build, and store the nested runtime environment, i.e. the inner container.

### Runtime image

The _runtime environment or image_ MUST be represented by a [Docker image v1.2.0](https://github.com/docker/docker/blob/master/image/spec/v1.2.md).

!!! note
    A concrete implementation of ERC may choose to rely on constructing the runtime environment from the manifest when needed, e.g. for export to a repository, while the ERC is constructed.

The base directory MUST contain a [tarball](https://en.wikipedia.org/wiki/Tar_(computing)), i.e. an archive file, of a Docker image as created be the command `docker save`, see [Docker CLI save command documentation](https://docs.docker.com/engine/reference/commandline/save/), as defined in version [`1.12.x`](https://github.com/docker/docker/blob/1.12.x/docs/reference/commandline/save.md).

The image MUST have a tag `erc:<erc identifier`, for example `erc:b9b0099e-9f8d-4a33-8acf-cb0c062efaec`.

The image file MAY be compressed.

The tar archive file names MUST be `image` with an appropriate file extension, such as `.tar`, `.tar.gz` (if a [gzip compression is used for the archive](https://en.wikipedia.org/wiki/Tar_(computing)#Suffixes_for_compressed_files)) or `.bin`, and have an appropriate mime type, e.g. `application/vnd.oci.image.layer.tar+gzip`.

!!! note
    Before exporting the Docker image, it should be [build](https://docs.docker.com/engine/reference/commandline/build/) from the runtime manifest, including the tag which can be used to identify the image, for example:
    ```bash
    docker build --tag erc:b9b0099e-9f8d .
    docker images erc:b9b0099e-9f8d
    docker save erc:b9b0099e-9f8d > image.tar
    # save with compression:
    docker save erc:b9b0099e-9f8d | gzip -c > image.tar.gz
    ```
    Do _not_ use `docker export`, because it is used to create a snapshot of a container, which must not match the Dockerfile anymore as it may have been [manipulated](../glossary.md#manipulate) during a run.

### Runtime manifest

The _runtime manifest_ MUST be represented by a valid `Dockerfile`, see [Docker builder reference](https://docs.docker.com/engine/reference/builder/), as defined in version [`1.12.x`](https://github.com/docker/docker/blob/1.12.x/docs/reference/builder.md).

The file MUST be named `Dockerfile`.

The Dockerfile MUST contain the build instructions for the runtime environment and MUST have been used to create the image saved to the [runtime image](#runtime-iamge) using `docker build`, see [Docker CLI build command documentation](https://docs.docker.com/engine/reference/commandline/build/), as defined in version [`1.12.x`](https://github.com/docker/docker/blob/1.12.x/docs/reference/commandline/build.md).
The build SHOULD be done with the option `--no-cache=true`.

The Dockerfile MUST NOT use the `latest` tag in the instruction `FROM`.

!!! note
    The "latest" tag is [merely a convention](http://container-solutions.com/docker-latest-confusion/) to denote the latest available image, so any tag can have undesired results.
    Nevertheless, using an image tagged "latest" makes it much more likely to change over time.
    Although there is no guarantee that images tagged differently, e.g. "v1.2.3" might not change as well, using such tags shall be enforced here.

The Dockerfile SHOULD contain the label `maintainer` to provide authorship information.

The Dockerfile MUST have an active instruction `CMD`, or a combination of the instructions `ENTRYPOINT` and `CMD`, which executes the packaged analysis.

The Dockerfile SHOULD NOT contain `EXPOSE` instructions.

### Docker control statements

The control statements for Docker executions comprise `load`, for importing an image from the archive, and `run` for starting a container of the loaded image.
Both control statements MUST be configured by using nodes of the same name under the root-level node `execution` in the ERC configuration file.
Based on the configuration, an implementation can construct the respective run-time commands, i.e. [`docker load`](https://docs.docker.com/engine/reference/commandline/load/) and [`docker run`](https://docs.docker.com/engine/reference/run/), using the correct image file name and further parameters (e.g. performance control options).

!!! tip "Example"
    The following example shows default values for `image` and `manifest` and typical values for `run`.

    ```yml
    id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
    version: 1
    execution:
      image: image.tar.gz
      manifest: Dockerfile
      run:
        environment:
    	  - TZ=CET
    ```

!!! note
    The Docker CLI commands constructed based on this configuration by an implementing service could be as follows:
    
    ```bash
    docker load --input image.tar
    docker run -it --name run_b9b0099e -e TZ=CET -v /storage/erc/abc123:/erc erc:b9b0099e-9f8d-4a33-8acf-cb0c062efaec
	```
	
	In this case the implementation uses `-it` to pass stdout streams to the user and adds an identifier for the container using `--name`.

The only option for `load` is `quiet`, which may be set to Boolean `true` or `false`.

The only option for `run` is `environment` to set environment variables inside containers as defined in [docker-compose](https://docs.docker.com/compose/environment-variables/#setting-environment-variables-in-containers).
Environment variables are defined as a list separated by `=`.

!!! tip "Example for `load` and `run` properties"
    ```yml
    execution:
      load:
        quiet: true
      run:
        environment:
    	  - DEBUG=1
    	  - TZ=CET
    ```

The environment variables SHOULD be used to fix settings out of control of the contained code that can hinder successful ERC [checking](../glossary.md#check), e.g. by setting a time zone to avoid issues during checking.

The output of the container during execution MAY be shown to the user to convey detailed information to users.

### Making data, code, and text available within container

The runtime environment image contains all dependencies and libraries needed by the code in an ERC.
Especially for large datasets, it in unfeasible to replicate the complete dataset contained within the ERC in the image.
For archival, it can also be confusing to replicate code and text, albeit them being relatively small in size, within the container.

Therefore a host directory is [mounted into a container](https://docs.docker.com/engine/reference/commandline/run/#mount-volume--v---read-only) at runtime using a [data volume](https://docs.docker.com/engine/tutorials/dockervolumes/#mount-a-host-directory-as-a-data-volume).

The Dockerfile SHOULD NOT contain a `COPY` or `ADD` command to include data, code or text from the ERC into the image.
It may be used to copy code or libraries which must be available during the image build.

The Dockerfile MUST contain a `VOLUME` instruction to define the mount point of the ERC base directory within the container.
This mount point MUST be `/erc`.

!!! tip "Example Dockerfile"
    In this example we use a [_Rocker_](https://github.com/rocker-org/rocker) base image to reproduce computations made in R.

    ```Dockerfile
    FROM rocker/r-ver:3.3.3

    RUN apt-get update -qq \
    	&& apt-get install -y --no-install-recommends \
    	## Packages required by R extension packages
    	# required by rmarkdown:
    	lmodern \
    	pandoc \
    	# for devtools (requires git2r, httr):
    	libcurl4-openssl-dev \
    	libssl-dev \
    	git \
    	# for udunits:
    	libudunits2-0 \
    	libudunits2-dev \
    	# required when knitting the document
    	pandoc-citeproc \
    	&& apt-get clean \
    	&& rm -rf /var/lib/apt/lists/*

    # install R extension packages
    RUN install2.r -r "http://cran.rstudio.com" \
    	  rmarkdown \
    	  ggplot2 \
    	  devtools \
    	  && rm -rf /tmp/downloaded_packages/ /tmp/*.rd

    # Save installed packages to file
    RUN dpkg -l > /dpkg-list.txt

    LABEL maintainer=o2r \
      description="This is an ERC image." \
    	info.o2r.bag.id="123456"

    VOLUME ["/erc"]

    ENTRYPOINT ["sh", "-c"]
    CMD ["R --vanilla -e \"rmarkdown::render(input = '/erc/myPaper.rmd', \
        output_dir = '/erc', output_format = rmarkdown::html_document())\""]
    ```

    See also: [Best practices for writing Dockerfiles](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#run).

!!! tip "Main and display file in the container"
    The fixed mount point have the advantage that users and tools can be sure the main and display files are usually available at `/erc/main.Rmd` and `/erc/display.html` respectively.

## R workspaces

ERC support the [R](https://www.r-project.org/) software environment for statistical computing and graphics.

### Structure

The structure within the ERC contents directory are intentionally unspecified.
However, the contents structure MAY follow conventions or be based on templates for organizing research artifacts.

If a convention is followed then it SHOULD be referenced in the ERC configuration file as a node `convention` within the `structure` section.
The node's value can be any text string which uniquely identifies a convention, but a URI or URL to either a human-readable description or formal specification is RECOMMENDED.

A non-exhaustive list of potential conventions and guidelines _for R_ is as follows:

- [ROpenSci rrrpkg](https://github.com/ropensci/rrrpkg)
- [Jeff Hollister's manuscriptPackage](https://github.com/jhollist/manuscriptPackage)
- [Carl Boettiger's template](https://github.com/cboettig/template)
- [Francisco Rodriguez-Sanchez's template](https://github.com/Pakillo/template)
- [Ben Marwick's template](https://github.com/benmarwick/template)
- [Karl Broman's comments on reproducibility](http://kbroman.org/knitr_knutshell/pages/reproducible.html)

!!! tip "Example for using the ROPenSci `rrrpkg` convention"
    The convention is identified using the public link on GitHub.
    ```yml
    ---
    id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
    spec_version: 1
    structure:
      convention: https://github.com/ropensci/rrrpkg
    ```

### R Markdown main file

The ERC's _main file_ for R-based analyses SHOULD be [R Markdown](http://rmarkdown.rstudio.com/).

The main document SHOULD NOT contain code that loads pre-computed results from files, but conduct all analyses, even costly ones, during document weaving.

The document MUST NOT use `cache=TRUE` on any of the code chunks (see [`knitr` options](https://yihui.name/knitr/options/).
While the previously cached files (`.rdb` and `.rdx`) MAY be included, they SHOULD NOT be used during the rendering of the document.

!!! note
    A popular alternative solution is [Sweave](http://www.statistik.lmu.de/~leisch/Sweave/) with the `.Rnw` extension, which is still widely used for vignettes. R Markdown was chosen of LaTex for its simplicity for users who are unfamiliar with LaTeX.

### Fixing the environment in code

The time zone MUST be fixed to `UTC` [Coordinated Universal Time](https://en.wikipedia.org/wiki/Coordinated_Universal_Time)) to allow validation of output times (potentially broken by different output formats) by using the following code within the RMarkdown document, or other code to that effect.

```r
Sys.setenv("TZ" = "UTC")
```

The manifest file (i.e. `Dockerfile`) MUST run a plain R session without loading `.RData` files or profiles at startup, i.e. use `R --vanilla`.

## Interactive ERC

Enabling interaction with the contents of an ERC is a crucial goal of this specification (see [Preface](#preface)).
Therefore this section defines metadata to support two goals:

- aide [inspecting](../glossary.md#inspect) users to identify core functions and parameters of an analysis, and
- allow supporting software tools to create interactive renderings of ERC contents for [manipulation](../glossary.md#manipulate).

These goals are manifested in the **UI bindings** as part of the ERC configuration file under the root level property `ui_bindings`.

An ERC MUST denote if UI bindings are present using the boolean property `interactive`.
If the property is missing it defaults to `false`.
An implementation MAY use the indicator `interactive: true` to provide other means of displaying the display file.

!!! tip "Example for minimal interaction configuration"
    ```yml
    id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
    spec_version: 1
    ui_bindings:
      interactive: true
    ```

An ERC MAY embed multiple concrete UI bindings.
Each UI binding is represented by a YAML dictionary.

It MUST comprise a purpose and a widget using the fields `purpose` respectively `widget` (both of type string).
The values of these fields SHOULD use a concept of an ontology to clearly identify their meaning.

A _purpose_ defines the user's intention, for example [manipulating](../glossary.md#manipulate) a variable or [inspecting](../glossary.md#inspect) dataset or code.
A _widget_ realizes the purpose with a concrete interaction paradigm chosen by the author, for example an input slider, a form field, or a button.

For each widget, implementations MAY use the properties `code`, `data`, and `text` to further describe how a specific UI binding acts upon the respective part of the ERC.

!!! tip "Example of two UI bindings"
    ```yml
    id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
    spec_version: 1
    ui_bindings:
      interactive: true
      bindings:
        - purpose: http://.../data-inspection
          widget: http://.../tabular-browser
          code: [...]
          data: [...]
          text: [...]
        - purpose: http://.../parameter-manipulation
          widget: http://.../dropdown
    ```

## Preservation of ERC

This section places the ERC in the context of preservation workflows by defining structural information and other metadata that guarantee interpretability and enable the bundling of the complete ERC as a self-contained, archivable digital object.

### Archival bundle

For the purpose of transferring and storing a complete ERC, it MUST be packaged using the [BagIt File Packaging Format (V0.97)][bagit] (BagIt) as the outer container.
BagIt allows to store and transfer arbitrary content along with minimal metadata as well as checksum based payload validation.

The remainder of this section comprises

- a description of the outer container,
- a BagIt profile,
- a package leaflet, and
- secondary metadata files.

#### BagIt outer container

The ERC base directory MUST be the BagIt payload directory `data/`.
The path to the ERC configuration file subsequently MUST be `<path-to-bag>/data/erc.yml`.

The bag metadata file `bagit.txt` MUST contain the case-sensitive label `Is-Executable-Research-Compendium` with the case-insensitive value `true` to mark the bag as the outer container of an ERC.

Implementations SHOULD use this field to identify an ERC.

!!! tip "Example `bagit.txt`"
    ```txt
    Payload-Oxum: 2172457623.43
    Bagging-Date: 2016-02-01
    Bag-Size: 2 GB
    Is-Executable-Research-Compendium: true
    ```

!!! tip "Example file tree for a bagged ERC"
    ```txt
    ├── bag-info.txt
    ├── bagit.txt
    ├── data
    │   ├── 2016-07-17-sf2.Rmd
    │   ├── erc.yml
    │   ├── metadata.json
    │   ├── Dockerfile
    │   └── image.tar
    ├── manifest-md5.txt
    └── tagmanifest-md5.txt
    ```

#### BagIt profile - DRAFT

!!! note
    The elements of the o2r Bagit Profile is yet to be specified.
    This section is under development.
    Current BagIt tools do not include an option to add a BagIt Profile automatically.

A [BagIt Profile][bagitprofiles] as outlined below would make the requirements more explicit.
The BagIt Profiles Specification Draft allows users of BagIt bags to coordinate additional information, attached to bags.

```json
{
  "BagIt-Profile-Info":{
  "BagIt-Profile-Identifier":"http://o2r.info/erc-bagit-v1.json",
  "Source-Organization":"o2r.info",
  "Contact-Name":"o2r Team",
  "Contact-Email":"o2r@uni-muenster.de",
  "External-Description":"BagIt profile for packaging
        executable research compendia.",
  "Version":"1"
  },
  "Bag-Info":{
    "Contact-Name":{
       "required":true
    },
    "Contact-Email":{
       "required":true
    },
    "External-Identifier":{
       "required":true
    },
    "Bag-Size":{
       "required":true
    },
    "Payload-Oxum":{
       "required":true
    }
  },
  "Manifests-Required":[
    "md5"
  ],
  "Allow-Fetch.txt":false,
  "Serialization":"optional",
  "Accept-Serialization":[
     "application/zip"
  ],
  "Tag-Manifests-Required":[
    "md5"
  ],
  "Tag-Files-Required":[
     ".erc/metadata.json",
     "erc.yml"
  ],
  "Accept-BagIt-Version":[
     "0.96"
  ]
}
```

[bagit]: http://tools.ietf.org/html/draft-kunze-bagit
[bagitprofiles]: https://github.com/ruebot/bagit-profiles

#### Package leaflet

Each ERC MUST contain a package leaflet, describing the schemas and standards used. Available schema files are supposed to be included with the ERC, if available (licenses for these schemas may apply).

!!! tip "Example package leaflet"
    ```json
    {
    "standards_used": [
        {
            "o2r": {
                    "map_description": "maps raw extracted metadata to
                        o2r schema compliant metadata",
                "mode": "json",
                "name": "o2r",
                "outputfile": "metadata_o2r.json",
                "root": ""
            }
        },
        {
            "zenodo_sandbox": {
                    "map_description": "maps o2r schema compliant MD to
                        Zenodo Sandbox for deposition creation",
                "mode": "json",
                "name": "zenodo_sandbox",
                "outputfile": "metadata_zenodo_sandbox.json",
                "root": "metadata"
            }
        }
    ]
}
    ```

Elements used for each schema standard used are contributed via the MD mapping files in the o2r meta tool suite.

#### Secondary metadata files

The ERC as an object can be used in a broad range of cases. For example, it can be an item under review during a journal publication, it can be the actual publication at a workshop or conference or it can be a preserved item in a digital archive. All of these have their own standards and requirements to apply, when it comes to metadata.

These metadata requirements _are not_ part of this specification, but the following conventions are made to simplify and coordinate the variety.

Metadata specific to a particular domain or use case MUST replicate the information required for the specific case in an independent file.
Domain metadata SHOULD follow domain conventions and standards regarding format and encoding of metadata.
Duplicate information is accepted, because it lowers the entry barrier for domain experts and systems, who can simply pick up a metadata copy in a format known to them.

Metadata documents of specific use cases MUST be stored in a directory `.erc`, which is a child-directory of the ERC base directory.

Metadata documents SHOULD be named according to the used standard/model, format/encoding, and version, e.g. `datacite40.xml` or `zenodo_sandbox10.json`, and SHOULD use a suitable mime type.

##### Requirements of secondary metadata

In order to comply to their governing schemas, secondary metadata must include the mandatory information as set by 3rd party services. While the documentation of this quality is a perpetual task, we have gathered the information most relevant our selection of connected services.

**Zenodo**

+ Accepts metadata as `JSON`.
+ Mandatory elements:
	+ Upload Type (e.g. Publication)
	+ Publication Type
	+ Title
	+ Creators
	+ Description
	+ Publication Date
	+ Access Right
	+ License

**DataCite (4.0)**

+ Accepts metadata as `XML`.
+ Mandatory elements:
	+ Identifier
	+ Creator
	+ Title
	+ Publisher
	+ Publication Year
	+ Resource Type

### Development bundle

While complete ERCs are focus of this specification, for collaboration and offline [inspection](../glossary.md#inspect) it is useful to provide access to parts of the ERC.
To support such use cases, a _development bundle_ MAY be provided by implementations.
This bundle most importantly would not include the _runtime image_, which is potentially a large file.

The _development bundle_ SHOULD always include the _main file_ and (e.g. by choice of the user, or by an implementing platform) MAY include other relevant files for reproduction or editing purposes outside of the runtime environment, such as input data or the _runtime manifest_ for manual environment recreation.

### Content metadata

The current JSON dummy file to visualises the properties. These elements SHOULD be filled out as good as possible in the user interface.

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
	"keywords": [],
    "license": {"text": None,
            "data": None,
            "code": None,
            "uibindings": None,
            "md": None
            },
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
    "viewfiles": []
}
```

The path to the o2r metadata file MUST be

`<path-to-bag>/data/metadata_raw.json`

and the refined version `metadata_o2r.json`.

### Description of o2r metadata properties

- `access_right` _String_.
- `creators` _Array of objects_.
- `creators.name` _String_.
- `creators.orcid` _String_.
- `creators.affiliation` _String_.
- `codefiles` _Array of strings_ List of all files of the recursively parsed workspace that have an extension belonging to a ("R") codefile.
- `communities` _Array of objects_ prepared zenodo MD element
- `communities[0].identifier` _String_. Indicating the collection as required in zenodo MD, default "o2r".
- `depends` _Array of objects_.
- `depends.operatingSystem` _String_.
- `depends.identifier` _String_.
- `depends.packageSystem` _String_. URL
- `depends.version` _String_.
- `description` _String_. A text representation conveying the purpose and scope of the asset (the abstract).
- `displayfile` _String_. The suggested file for viewing the text of the workspace, i.e. a rendering of the suggested mainfile.
- `displayfile_candidates` _Array of strings_. An unsorted list of candidates for displayfiles.
- `ercIdentifier` _String_. A universally unique character string associated with the asset as executable research compendium, provided by the o2r service.
- `identifier` _Object_.
- `inputfiles` _Array of strings_. A compiled list of files from the extracted workspace that is called or used in the extracted code of the workspace.
- `interaction` TBD
- `keywords` _Array of strings_. Tags associated with the asset.
- `license`_Object_.  License information for the entire ERC.
- `license.code` _String_. License information for the code included.
- `license.data `_String_. License information for the data included.
- `license.md` _String_. License information for the metadata included. Should be cc0 to include in catalogues.
- `license.text`_String_. License information for the text included.
- `license.uibindings` _String_. License information for the UI-bindings included.
- `mainfile` _String_. The suggested main file of workspace
- `mainfile_candidates` _Array_. Unsorted list of mainfile candidates of the workspace.
- `paperLanguage` _Array of strings_. List of guessed languages for the workspace.
- `publication_date` _String_. The publication date of the paper publication as ISO8601 string.
- `publication_type` _String_.
- `related_identifier` _String_.
- `spatial` _Object_. Spatial information of the workspace.
- `spatial.files` _Array of objects_.
- `spatial.union` _Array of objects_.
- `temporal` _Object_. Aggregated information about the relevant time period of the underlying data sets.
- `temporal.begin`
- `temporal.end`
- `title` The distinguishing name of the paper publication.
- `upload_type` _String._ Zenodo preset. Defaults to "publication".

## ERC checking

### Procedure

A core feature ERCs are intended to support is comparing the output of an ERC executions with the original outputs.
Therefore [checking](../glossary.md#check) an ERC always comprises two steps: the execution and the comparison.

The files included in the comparison are the _comparison set_.
An implementation MUST communicate the comparison set to the user as part of a check.

Previous to the check, an implementation SHOULD conduct a basic validation of the outer container's integrity, i.e. check the file hashes.
The output of the image execution can be shown to the user to convey detailed information on progress or errors.

### Comparison set file

The ERC MAY contain a file named `.ercignore` in the base directory to define the comparison set.

Its purpose is to provide a way to efficiently exclude files and directories from [checking](../glossary.md#check).
If this file is present, any files and directories within the outer container which match the patterns within the file `.ercignore` will be excluded from the checking process.
The check MUST NOT fail when files listed in `.ercignore` are failing comparison.

The file MUST be UTF-8 (without BOM) encoded.
The newline-separated patterns in the file MUST be [Unix shell globs](https://en.wikipedia.org/wiki/Glob_(programming)).
For the purposes of matching, the root of the context is the ERC's base directory.

Lines starting with `#` are treated as comments and MUST be ignored by implementations.

!!! tip "Example `.ercignore` file"
    ```bash
    # comment
    .erc
    */temp*
    data-old/*
    ```

!!! note
    If using [md5](https://tools.ietf.org/html/rfc1321) file hashes for comparison, the set could include plain text files, for example the `text/*` [media types](https://en.wikipedia.org/wiki/Media_type) (see [IANA's full list of media types](https://www.iana.org/assignments/media-types/media-types.xhtml).
    Of course the comparison set should include files which contain results of an analysis.

### Comparing plain text documents

...

### Comparing graphics and binary output

This section outlines possibilities beyond simple comparison and incorporates "harder" to compare files and what to do with them, e.g. plots/figures, PDF files, ...





[c99-unspecified]: http://www.open-std.org/jtc1/sc22/wg14/www/C99RationaleV5.10.pdf#page=18
[rfc2119]: http://tools.ietf.org/html/rfc2119
[issues]: https://github.com/o2r-project/erc-spec/issues
[repo]: https://github.com/o2r-project/erc-spec
[rfc3986]: https://tools.ietf.org/html/rfc3986
[uuid]: https://en.wikipedia.org/wiki/Universally_unique_identifier
