# User guide: ERC creation

This user guide comprises instructions how to create an ERC _by hand_.
It is thus limited to mandatory elements in some places.
However, a fundamental goal of the ERC specification is to be simple enough to allow manual ERC creation as demonstrated in this document.
It is supposed to ease the understanding of the ERC especially for the authors of scientific publications.
For using tools or services for creation and validation of ERCs, please see the [developer guide](../dev-guide/index.md).

!!! note
    This is a draft.
    If you have comments or suggestions please file them in the <a href="https://github.com/o2r-project/erc-spec/issues">issue tracker</a>.
    If you have explicit changes please fork the <a href="https://github.com/o2r-project/erc-spec">git repo</a> and submit a pull request.

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

## Step 2: create image container for runtime

To create a working ERC you must include a complete environment description and an executable image.

We recommend using Docker, so a Dockerfile and a Docker image tarball archive file, to achieve these goals.

See the [runtime section](../spec/index.md#nested-runtime) for detailed requirements, including links to the relevant Docker commands.

## Step 3: create metadata

### ERC metadata

Structural & administrative metadata must be put into the ERC configuration file `erc.yml` as defined in the [specification](../spec/index.md#erc-configuration-file).

When creating the erc manually, you can receive a uuid4 as `id` for the erc configuration file using an online service, e.g. [uuidgenerator](https://www.uuidgenerator.net/version4) or one of the numerous implementations for the common programming languages.

### License metadata

Please consult your employer or legal department for a suitable license for your work.
Make sure you hold the copyright for any code that you want to release under a self-chosen license and that the license is compatible with the conditions of licenses of used data or software.

A good discussion of the legal aspects of reproducible research is given in Victoria Stodden's ["The Legal Framework for Reproducible Scientific Research: Licensing and Copyright"](https://aip.scitation.org/doi/pdf/10.1109/MCSE.2009.19) ([public preprint](https://web.stanford.edu/~vcs/papers/LFRSR12012008.pdf)) .

Further resources that are linked here without any endorsement or being checked:

- [choosealicense.com](https://choosealicense.com) (for code)
- [opendefinition.org](http://opendefinition.org) (for code, data, text)
- [A short lecture on Open Licensing by Lorena A. Barba](https://speakerdeck.com/labarba/a-short-lecture-on-open-licensing)

License information must be put into the ERC configuration file `erc.yml` as defined in the [specification](../spec/index.md#erc-configuration-file).

### Content metadata

Content metadata are used for making your work findable.
Properties for the content metadata are defined in the [specification](../spec/index.md#content-metadata) and must be put into the `metadata.json` file.

### Secondary metadata

_As of now, we do not recommend creating secondary metadata by hand._

Secondary metadata are used for third party services, e.g. repositories that define their own obligatory metadata.
In general they can be added in different formats to support different use cases.

More information on secondary metadata can be found in the [preservation section](../spec/index.md#preservation-of-erc).


## Step 4: validate

You can use the container created in step 2 for validation purposes, too.
Run the analysis in the container, then copy the analysis output to a temporary directory on the host system, and finally compare the original workspace and the temporary directory according the [validation rules](../spec/index.md#validation) to ensure a complete replication.

## Step 5: create bag

To create a package that is suitable for being stored in an archive or repository, ERCs must be bundled as BagIt bags.
Take a look at the [preservation section](../spec/index.md#preservation-of-erc) for a detailed background about the purpose of BagIt and other digital preservation aspects.


### Third party tools for creating BagIt bags

- [Bagger](https://github.com/LibraryOfCongress/bagger) (version 2.7, Java-based, with UI)
- [bagit-python](https://libraryofcongress.github.io/bagit-python/) (Python package)

### Creating the bag

In this guide we will create the bag manually by using the Library of Congress's (LoC) tool _Bagger_, listed above.

1. Start by selecting "Create new bag" from the main menu and proceed with "&lt;no profile&gt;".
2. Add your files with the "+" Button.
3. Uncheck the "Standard" feature in the Bag-Info-Editor on the right and add `ERC-Version` with the appropriate version you want to use, e.g. `1`. Optionally fill out additional Bag-Info metadata, e.g. _contact information_.
4. Save your bag using the main menu.

### Validating the bag

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

You can validate your bag with _Bagger_ by loading the bag and then clicking on "Validate Bag" in the main menu.
The programme will check for completeness of BagIt-related files and verify the integrity of the data files by computing their checksums (hashes) and report any potential issues.
