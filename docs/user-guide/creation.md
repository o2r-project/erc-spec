# User guide: ERC creation

This user guide comprises instructions how to create an ERC _by hand_.
It is thus limited to mandatory elements in some places.
However, a fundamental goal of the ERC specification is to be simple enough to allow manual ERC creation as demonstrated in this document.
For using tools or services for creation and validation of ERCs, please see the [developer guide](../dev-guide/index.md).

<div class="alert note" markdown="block">
This is a draft. If you have comments or suggestions please file them in the <a href="https://github.com/o2r-project/erc-spec/issues">issue tracker</a>. If you have explicit changes please fork the <a href="https://github.com/o2r-project/erc-spec">git repo</a> and submit a pull request.
</div>

## Step 1: create workspace

_Do your research and create something useful that works for you._
The ERC specification makes no restrictions on the contents of a workspace, but guidelines and best practices do exist and should be followed by users during their research i.e. even before packaging it in an ERC.

### Code and versioning

If the base directory contains a script file or source code used to conduct the packaged analysis, we recommend this code is managed using [distributed version control](https://en.wikipedia.org/wiki/Distributed_version_control), see [software carpentry guidelines](https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/blob/gh-pages/index.md#keeping-track-of-changes).
The base directory should contain a copy of the complete repository in that case.

### Workspace structure

The base directory contents should follow common guidelines to project organisation.
Some useful resources are

- [Software carpentry paper "Good enough practices in Scientific Computing"](https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/blob/gh-pages/index.md#project-organization)
- [ROpenSci research compendium](https://github.com/ropensci/rrrpkg)).
- [ROpenSci reproducibility guide](https://ropensci.github.io/reproducibility-guide/sections/introduction)

## Step 2: create container for runtime

To create a working ERC you must include a complete environment description and an executable image.

We recommend using Docker, so a Dockerfile and a Docker container tarball, to achieve these goals.

See the [Docker extension](../spec/docker.md) for detailed requirements, including links to the relevant Docker commands.

## Step 3: create metadata

### ERC metadata

Structural & administrative metadata must be put into the ERC configuration file `erc.yml` as defined in the [specification](../spec/index.md#erc-configuration-file).

### License metadata

Please consult your employer or legal department for a suitable license for your work. Make sure you hold the copyright for any code that you want to release under a self-chosen license.

Further resources that are linked here without any endorsement or being checked:

- [choosealicense.com](https://choosealicense.com) (for code)
- [opendefinition.org](http://opendefinition.org) (for code, data, text)
- [A short lecture on Open Licensing by Lorena A. Barba](https://speakerdeck.com/labarba/a-short-lecture-on-open-licensing)

License information must be put into the ERC configuration file `erc.yml` as defined in the [specification](../spec/index.md#erc-configuration-file).

### Content metadata

Content metadata are used for making your work findable. Properties for the content metadata are defined in the [specification](../spec/index.md#Content-metadata) and must be put into the `metadata.json` file.

<!-- `erc_metadata.json` == `web-api/<compendium>.metadata.o2r`, or `bagit.txt`? -->


### Secondary metadata

_As of now, we do not recommend creating secondary metadata by hand._

Secondary metadata are used for third party services, e.g. repositories that define their own obligatory metadata.
In general they can be added in different formats to support different use cases.

More information on secondary metadata can be found in the [archival extention](../spec/archival.md#Secondary-metadata-files).


## Step 4: validate

You can use the container created in step 2 for validation purposes, too. Run the analysis in the container, then copy the analysis output to a temporary directory on the host system, and finally compare the original workspace and the temporary directory according the [validation rules](index.md#validation) to ensure a complete replication.

<!-- _To simplify the validation process, an ERC validation tool and accompanying [validation extension](../spec/index.md#Validation) are under development._ -->

## Step 5: create bag

To create a package that is suitable for being stored in an archive or repository, ERCs must be bundled as BagIt bags. Follow the instructions in the [archival extension](../spec/archival.md) to create a bag for your work.

Useful third party tools for creating and validating BagIt bags:

- [Bagger](https://github.com/LibraryOfCongress/bagger) (Java-based, with UI)
- [bagit-python](https://libraryofcongress.github.io/bagit-python/) (Python package)

A file tree for the final bagged ERC may look like this:

```txt
├── bag-info.txt
├── bagit.txt
├── data
│   ├── 2016-07-17-myPaper.Rmd
│   ├── erc.yml
│   ├── metadata.json
│   ├── Dockerfile
│   └── image.tar
├── manifest-md5.txt
└── tagmanifest-md5.txt
```
