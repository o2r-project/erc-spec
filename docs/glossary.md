# Glossary

## (Computational) Analysis

A scientific workflow that is to be preserved in an ERC.
It conducts a number of operations on data and generates an output (text, numbers, plots).

## Bag

See [BagIt specification](https://tools.ietf.org/html/draft-kunze-bagit).

> A set of opaque data contained within the structure defined by this specification.

## Compendium contents

See [ERC contents](#erc-contents)

## Container

A receptacle holding a collection of things ("payload" or "contents").
In the context of this specification, two containers are distinguished: [runtime container](#runtime-container) and [outer container](#outer-container).

## Check

A subconstituent of [_Examine_](#examine).
Checking an ERC is a syntactical validation, which may be largely automated by a software tool reporting the check result and potential errors.
A check comprises (a) the validation of a concrete ERC against the ERC specification, e.g. are required files and metadata fields present, and (b) an execution of the contained analysis.
The execution includes a comparison of the result files in the just executed inner container with the result stored in the outer container.

## Create

One of the major constituents of ERC interaction.
The user can create an ERC by following the technical instructions included in the Specification (ERC Spec) or use the o2r reproducibility service.
For more information, see [erc-spec/user-guide/creation/]().

## Discover

One of the major constituents of ERC interaction.
Discovery comprises the [findability](https://en.wikipedia.org/wiki/Findability) of the ERC as well as the exploration of its features, e.g. time and space driven search operations.

## ERC

Executable Research Compendium, see [article](https://doi.org/10.1045/january2017-nuest).

## ERC contents

See [workspace](#workspace).

## ERC metadata

Schema compliant information about the ERC, its contents and creators.

## Examine

One of the major constituents of ERC interaction.
It comprises _Check_, _Inspect_, _Manipulate_ and _Substitute_.
To examine an ERC means to explore its contents in depth, i.e. check the reproduced version, inspect text, code and data, manipulate interactive elements, as well as exchange input data.

## Inner container

See [runtime container](#runtime-container)

## Inspect

A subconstituent of [_Examine_](#examine).
Inspection includes looking at all the contents of an ERC, such as code or data files, and metadata documents.
A user conducting inspection evaluates the meaning of the ERC's artifacts.

## Dependency

If software/[library](https://en.wikipedia.org/wiki/Library_(computing)) `X` is required by software/tool `Y` to function properly, then `Y` has the dependency `X` or `X` is a dependency of `Y`.
Collecting all the right dependencies, which work with each other, can be a hard problem, see [Dependency hell](https://en.wikipedia.org/wiki/Dependency_hell).
Dependencies can be packages of the same language (like R extension package requiring another R extension package) or system dependencies (like a Python library from PyPI requiring a specific library available via the operating system [package manager](https://en.wikipedia.org/wiki/Package_manager)).

## Display file

The file in the container that a reader software uses as the first display to a user to read text and explore graphics.
The entry point for [examination](#examine). 

## Manipulate

A subconstituent of [_Examine_](#examine).
A manipulation comprises interactive changing of selected, pre-defined parameters that influence the computation packaged in an ERC.
For example, the number of layers in a neural network, the size/selection method of the training dataset in supervised machine learning, or the variogram model of geostatistical kriging.
These parameters are defined via [UI bindings](#ui-bindings).

## OAIS

The [Open Archival Information System](https://en.wikipedia.org/wiki/Open_Archival_Information_System) and its [reference model](https://web.archive.org/web/20131020200910/http://public.ccsds.org/publications/archive/650x0m2.pdf).

## Outer container

Term used to distinguish the "outer" [Bag](#bag) from the embedded [runtime container](#runtime-container).

## Reproducible, Reproducibility, Replication

See [section 2.1 "Definition of Reproducibility"](https://doi.org/10.1045/january2017-nuest).

## Runtime container

A [Linux container](https://en.wikipedia.org/wiki/LXC), more specifically a [Docker container](https://en.wikipedia.org/wiki/Docker_(software)), which is a special format to package an application and its [dependencies](#dependency).
For usage in this specification, the runtime container can be used to provide the [computational environment]() needed for execution of an ERC's workflow.
It is a transferable snapshot of the authors computer, but also documents the software used by an ERC.

## Runtime manifest

A formal description or recipe for a [runtime container](#runtime-container), more specifically a [Dockerfile](https://docs.docker.com/engine/reference/builder/).

> _Docker can build images automatically by reading the instructions from a Dockerfile. A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image._ [source](https://docs.docker.com/engine/reference/builder/)

## Substitute

A subconstituent of [_Examine_](#examine).
During a substitution, compatible parts of an ERC are exchanged, e.g. similar data sets for a given analysis, or exchanging an analysis script.
A substitution process usually creates a new ERC based on two input ERCs: the _base ERC_ and the _overlay ERC_.
One or several data or code files from the _overlay ERC_ replace corresponding files in the _base ERC_, to create a new ERC.

## UI bindings

Formal descriptions of parameters and interactions used during [_Examine_](#examine).
The UI bindings are included in the configuration file and may be created manually or with help of a user-friendly wizard.

## Workspace

The files created by the author of the original analysis.
The workspace is packaged together with ERC metadata, [runtime container](#runtime-container) and [runtime manifest](#runtime-manifest) in the payload directory of the [outer container](#outer-container).
