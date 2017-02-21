# o2r metadata schema documentation


## Schema location

_under development_


## Concept

According to the ERC creation workflow, we differentiate at least two states of metadata. The extractor creates _raw MD_ automatically, while the _refined MD_ are with the help of the user. 

Raw MD include any relevant meta information that the extractor can gather only by parsing the files of the work space (text, code and data). As such they include structural as well as content-related descriptive information. The refined MD can then be "brokered" to comply with third party services such as data repositories. These _mapped MD_ are translations that fulfull the formal requirements of a third party metadata schema.


**raw MD** | **refined MD** | **mapped MD** |
------ | ------ | ------ |
extracted |  user-assisted | translated
incomplete | complete | complete
maximized | reduced | reduced 
o2r | o2r | 3rd party 


The main purpose of the MD is to depict package dependencies and other requirements for reproducible computational environments.
In addition to this, descriptive MD are necessary to enable discovery functions of registries, data catalogues or repositories. This is done with existing modern metadata standards, e.g. DataCite 4.0 schema.


## Metadata elements _under development_

Current JSON dummy to visualise the schema properties

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
		"operatingSystem": null
	}],
	"description": null,
	"ercIdentifier": null,
	"file": {
		"filename": null,
		"filepath": null,
		"mimetype": null
	},
	"generatedBy": "o2r-meta metaextract.py",
    "interaction": {
        "interactive": false
    },
	"keywords": [],
	"license": null,
	"paperLanguage": [],
	"paperSource": null,
	"publicationDate": null,
	"r_comment": [],
	"r_input": [],
	"r_output": [],
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
	"version": null
}
```


## Rationales

Defining explanations on the concept of each metadata element in use.

+ `author` Contains a list of author related information.
+ `author.affiliation` A list of institutions, organizations or other groups that the creator of the asset is associated with.
+ `author.name` The name of the human individual, institution, organization, machine or other entity that acts as creator of the asset.
+ `author.orcid` the ORCid of the creator of the asset.
+ `depends` A block for each entity that the software is dependent on for execution.
+ `depends.identifier` An identifying name for the depending package.
+ `depends.version` The computer software and hardware required to run the software.
+ `depends.packageSystem` The package manager system that makes the dependency entity available.
+ `description` A text representation conveying the purpose and scope of the asset.
+ `ercIdentifier` A universally unique character string associated with the asset as _executable research compendium_.
+ `generatedBy` The entity, person or tool, that created the software.
+ `interaction` Information on how to interact with the asset.
+ `interaction.interactive` indicates interaction such as shiny app dynamics is possible.
+ `interaction.interactive` is the indicator, if shiny is present.
+ `keywords` Tags associated with the asset.
+ `paperLanguage` A list of language codes that indicate the language of the asset, e.g. _en_.
+ `paperSource` is the text document file of the paper.
+ `recordDateCreated` The date that this metadata record was created.
+ `softwarePaperCitation` A text string that can be used to authoritatively cite a research paper, conference proceedings or other scholarly work that describes the design, development, usage, significance or other aspect of the software.
+ `spatial` Information about the geometric bounding box of the underlying data/software.
+ `spatial.union` A Geojson object of the aggregated bounding boxes of the underlying data/software.
+ `temporal.begin` The starting point of said time period.
+ `temporal.end` The end point of said time period.
+ `temporal` Aggregated information about the relevant time period of the underlying data or contents.
+ `title` The distinguishing name associated with the asset.
+ `version` A unique string indicating a specific state of the software, i.e. an initial public release, an update or bug fix release, etc. No version format or schema is enforced for this value.
+ ~~`depends.operatingSystem` The operating system for the software to run under.~~
+ ~~`objectType` The category of the resource that is associated with the software. TO DO: controlled list, such as software, paper, data, image.~~
