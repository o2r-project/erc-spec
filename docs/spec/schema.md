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
		"affiliation": null,
		"orcid": null
	}],
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
	"interactionMethod": null,
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





