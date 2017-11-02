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
In the context of this specification, several containers are distinguished: [runtime container](#runtime-container) (with [Docker container](#docker-container) as a concrete instance) and [outer container](#outer-container).

## Check

A subconstituent of [_Examine_](#examine).
Checking an ERC is a syntactical validation, which may be largely automated by a software tool reporting the check result and potential errors.
A check comprises (a) the validation of a concrete ERC against the ERC specification, e.g. are required files and metadata fields present, and (b) an execution of the contained analysis.
The execution includes a comparison of the result files in the just executed inner container with the result stored in the outer container.

## Create

One of the major constituents of ERC interaction.
The user can create an ERC by following the technical instructions included in the Specification (ERC Spec) or use the o2r reproducibility service, which has been referentially implemented as "o2r platform".
For more information, see [erc-spec/user-guide/creation/]

## Discover

One of the major constituents of ERC interaction.
Discovery comprises the findability of the ERC as well as the exploration of its features, e.g. time and space driven search operations.

## Docker container

TBD

## ERC

Executable Research Compendium, see [this article](https://doi.org/10.1045/january2017-nuest)

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

TBD

## Substitute

A subconstituent of [_Examine_](#examine).
During a substitution, compatible parts of an ERC are exchanged, e.g. similar data sets for a given analysis, or exchanging an analysis script.
A substution process usually creates a new ERC based on two input ERCs: the _base ERC_ and the _overlay ERC_.
One or several data or code files from the _overlay ERC_ replace corresponding files in the _base ERC_, to create a new ERC.

## UI bindings

TBD

## Workspace

The files created by the author of the original analysis, packages together with ERC metadata in the [outer container](#outer-container).
