# o2r metadata schema documentation

## Schema location
Current schema draft for descriptive metadata of the asset, e.g. software:

- <https://raw.githubusercontent.com/o2r-project/o2r-meta/master/schema/json/o2r-meta-schema.json>

Current schema draft for interaction metadata, i.e. UI widgets:

- <https://raw.githubusercontent.com/o2r-project/o2r-meta/master/schema/json/o2r-meta-ui-schema.json>

## Purpose

This is a work-in-progress documentation of the metadata schema used for _executable research compendia_, focusing to depict package dependencies and other requirements for reproducible computational environments as well as compliance with existing modern metadata standards, e.g. DataCite 4.0 schema.
In its current state these metadate elements, properties and definitions build upon on the [CodeMeta](https://github.com/codemeta/codemeta) software metadata concepts, extending them for the interaction with software in the context of Reproducible Research. Rationales of CodeMeta equivalents are taken from or based on the corresponding descriptions.
The required information for a complete set of o2r metadata according to this schema are gathered by automated extraction and collection from the creator of the asset.

## Metadata elements _under development_

### Main Schema

- ```author``` (mandatory, 1-n, array)
 - ```authorAffiliation``` (mandatory, 1-n, array)
 - ```authorId``` (optional, 0-n, array)
 - ```authorName``` (mandatory, 1)
- ```dateCreated``` (optional, 0-1)
- ```depends``` (mandatory, 1-n, array)
 - ```operatingSystem``` (optional, 0-n, array)
 - ```identifier``` (mandatory, 1)
 - ```packageSystem``` (mandatory, 1)
 - ```version``` (mandatory, 1)
- ```description``` (mandatory, 1)
- ```ercIdentifier``` (mandatory, 1)
- ```generatedBy``` (mandatory, 1)
- ```interactionMethod``` (optional, 0-n, array)
- ```keywords``` (mandatory, 1-n, array)
- ```objectType``` (optional, 0-1)
- ```paperLanguage``` (optional, 0-n, array)
- ```recordDateCreated``` (optional, 0-1)
- ```spatial``` (mandatory, 1, array)
 - ```union``` (optional, 0-1, array)
- ```softwarePaperCitation``` (optional, 0-1)
- ```title``` (mandatory, 1)
- ```temporal``` (mandatory, 1-n, array)
 - ```union``` (optional, 0-1, array)
- ```version``` (mandatory, 1)

### UI Schema Draft
The following meta information are used to control widgets for interaction with ERCs on our platform.

- ```ercIdentifier``` (mandatory, 1)
- ```checkboxes``` (optional, 0-n)
 - ```label``` (mandatory, 1)
 - ```value``` (mandatory, 1)
 - ```is_checked``` (mandatory, 1)
 - ```parameter_type``` (mandatory, 1)
 - ```reference_point``` (mandatory, 1)
- ```radiobuttons``` (optional, 0-n)
 - ```label``` (mandatory, 1)
 - ```value``` (mandatory, 1)
 - ```is_checked``` (mandatory, 1)
 - ```parameter_type``` (mandatory, 1)
 - ```reference_point``` (mandatory, 1)
- ```sliders``` (optional, 0-n)
 - ```label``` (mandatory, 1)
 - ```value``` (mandatory, 1)
 - ```value_max``` (mandatory, 1)
 - ```value_min``` (mandatory, 1)
 - ```parameter_type``` (mandatory, 1)
 - ```reference_point``` (mandatory, 1)


## 3. Rationales

- author
> A block for each creator of the asset.

- ⌞ author/authorAffiliation
> The institution, organization or other group that the creator of the asset is associated with.

- ⌞ author/authorId
> A universally unique character string that is associated with the author, e.g."http://orcid.org/0000-0002-1825-0097".

- ⌞ author/authorName
> The name of the human individual, institution, organization, machine or other entity that acts as creator of the asset.

- dateCreated
> The date that a published version of the asset was created by the author.

- depends
> A block for each entity that the software is dependent on for execution.

- ⌞ depends/operatingSystem
> The operating system for the software to run under.

- ⌞ depends/identifier
> An identification string for the dependency entity that is unique in the corresponding package system.
 
- ⌞ depends/packageSystem
> The package manager system that makes the dependency entity available.
 
- ⌞ depends/version
> The computer software and hardware required to run the software.

- description
> A text representation conveying the purpose and scope of the asset.

- ercIdentifier
> A universally unique character string associated with the asset as _executable research compendium_.

- generatedBy
> The entity, person or tool, that created the software.

- interactionMethod
> The specified method(s) that can be used to interact with the software (e.g. command-line vs. GUI vs. Excel..., entry points).

- keywords
> Keywords (tags) associated with the asset.

- objectType
> The category of the resource that is associated with the software. TO DO: controlled list, such as software, paper, data, image...

- paperLanguage
> A list of the specific counties or regions that the software has been adapted to, e.g. “en-GB,en-US,zh-CN,zh-TW” (if using the ISO 639-1 standard codes).

- recordDateCreated
> The date that this metadata record describing the asset was created.

- spatial
> Information about the geometric bounding box of the underlying data/software.

- ⌞ spatial/union
> Geojson object of the aggregated bounding boxes of the underlying data/software.

- softwarePaperCitation
> A text string that can be used to authoritatively cite a research paper, conference proceedings or other scholarly work that describes the design, development, usage, significance or other aspect of the software.

- temporal
> Information about the time period of the underlying data/software.

- ⌞ temporal/union
> Aggregated information about the time period of the underlying data/software.

- title
> The distinguishing name associated with the asset.

- version
> A unique string indicating a specific state of the software, i.e. an initial public release, an update or bug fix release, etc. No version format or schema is enforced for this value.

