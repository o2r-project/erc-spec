# User guide: ERC examination

An Executable Research Compendium (ERC) can be examined using a supporting [user interface](#ui-based) or, in lack of such a tool or for higher control, [manually](#manually).

## UI-based

The o2r platform provides an interactive user interface for **examination of an ERC**.
The right-hand side of the start page provides a form to load a complete executable research compendium.

![Screenshot of o2r platform home page](/img/user-guide/examine-form.jpg)
<p class="caption">Screenshot of o2r platform: home page.</p>

The following sources and identifiers are supported:

- an _identifier of an ERC_ available in the reproducibility service at hand
- a _DOI_ or _full repository URL_ of a supported data repository
- a _repository-specific identifier_ of a supported data repository

!!! Note
    The demonstrator is only configured to ship (store) ERC to [Zenodo _Sandbox_](https://sandbox.zenodo.org/), therefore examination starting from DOIs is not commonly available because Zenodo Sandbox does not provide valid DOIs.
    A user may upload a valid compendium to "regular" Zenodo manually and then examine via a DOI.

Currently you must be locked in, as other security mechanisms are out of scope of the demonstration prototype.

![Screenshot of o2r platform home page](/img/user-guide/examine-form-filled-loggedin.jpg)
<p class="caption">Screenshot of o2r platform: home page with logged-in user and filled out examination form.</p>

After loading the ERC from the reproducibility service's database and file cache or from the data repository, you are taken to a compendium landing page and can continue with different **aspects of examination**:

![Screenshot of ERC landing page](/img/user-guide/examine-erc.jpg)
<p class="caption">Screenshot of o2r platform: ERC detail page, the "green" comparison button points out a successful reproduction.</p>

- **check** to run an analysis, i.e. ensure computational reproducibility
- **inspect** to closely evaluate core code and data files
- **manipulate** to adjust selected parameters when executing the computations
- **substitute** to switch out data or code files re-run computations

Check, manipulation, and substitution allow readers to interact with the packaged workflow.
Manipulation options are based on the _bindings_ provided as part of the compendium.
All these interactions result in a new output, the _reproduced display file_. It can be compared with the original display file included in the compendium.
The following screenshot shows the visual aid for comparison provided by the UI.

![Screenshot of ERC check comparison](/img/user-guide/examine-erc-compare.jpg)
<p class="caption">Screenshot of o2r platform: check comparison view with differences in figure highlighted, e.g. after substitution or manipulation.</p>

Furthermore you can examine the log files of the execution in the job log on the right hand side.

## Manual

[Nothing lasts forever](https://en.wikipedia.org/wiki/Nothing_Lasts_Forever).
While it is reasonable to assume that an ERC-based publication workflow is maintainable for some time (cf. [developer guide on ERC lifespan](/dev-guide/#lifespan), the ERC concept also supports a manual examination.
The ready-to-use user interface provided by the o2r project provides user-friendliness and shortcuts, but the same results can be achieved manually.
Of course this requires a higher level of expertise in the underlying tools.

The following sections mimic the steps conducted by the reproducibility service to load and examine a valid ERC.

### Download and extract

Download the ERC from a data repository to your local machine.

![Screenshot of ERC check comparison](/img/user-guide/zenodo-record.jpg)
<p class="caption">Screenshot of Zenodo record landing page with preview of contents of the downloadable archive file, in this case `PPhqW.zip`.</p>

Then extract the archive.
You may familiarise yourself with the [BagIt specification](https://en.wikipedia.org/wiki/BagIt#Specification), but you mostly just need to open the payload directory, `data`, in the extracted bag.

### Validate

The following checks can be made to ensure an ERC is valid:

- presence of mandatory files in the payload directory: `erc.yml`, `Dockerfile`, `image.tar(.gz)`
- the whole bag is valid, check e.g. with the [`bagit` Python library](https://pypi.org/project/bagit/)

### Examine

#### Inspect

Open the file `erc.yml` with a text viewer.
It is the entrypoint to an ERC both for software tools and humans.
The most important information in it is which files are the _main file_ and the _display file_.
Open the main file in a suitable viewer, e.g. a web browser for an HTML file, and the display file in a suitable viewer or editor.

The `erc.yml` further lists the _licenses_ for each part of the compendium.
Make sure your usage of the 

Secondary, but potentially very useful information, can be found in the `.erc` directory.
It contains log files from the creation of the compendium and metadata in different formats.
These files can be helpful to investigate provenance and authorship of a compendium.

#### Examine runtime

The runtime is defined in two levels: a _manifest_ describing the construction of the _image_.

The manifest, probably a `Dockerfile`, is readable both for humans and machines.
You can study the specification for the used manifest type and then understand all commands which were used to create the original computational environment.

The image, probably `image.tar`, is a [tarball](https://en.wikipedia.org/wiki/Tar_(computing)) of all files and directories making up the runtime environment.
You can study the image format specification, e.g. [Docker Image Specification v1.2.0](https://github.com/moby/moby/blob/master/image/spec/v1.2.md) (assumed for the remainder of this section), to understand the contents of the tarball.
Extract the tarball it to inspect the contained software, be it binaries, source files, or configurations.

The image also contains helpful metadata.
A file `manifest.json` describes the [lay](http://www.smashinglab.com/docker-image-vs-container-explained/)[ers](https://medium.com/@jessgreb01/digging-into-docker-layers-c22f948ed612) of the image.
The layers themselves are composed of a tarball with the files (`layer.tar`), which are layed over the lower layers, and metadata.

A file `<image hash>.json` includes metadata about the architecture and operating system the image was created on, the configuration, and a representation of all steps in the manifest (see the `history` object) that lead to the creation of the image and its layers.

#### Check

You may now run the workflow by executing the main file.
You have a choice of potential runtime environments:

- Your computer, using the locally installed software packages and system packages
- Recreate the runtime environment based on the _runtime manifest_
- Load and run the _runtime image_ from the ERC

The first approach is the most direct one, and if the results are the same, you can be quite sure the workflow is stable and reproducible.
Follow the instructions included in the main file or use well-known commands to compile the main file with the appropriate tools.

The last approach is closest to the environment that the original author had; this approach is used by the reproducibility service.
You must manually extract the reproduced display file from the container after running it.

In all approaches, after you have created the display file, you can compare it to the original, e.g. by opening them side by side.
You can also use tools to assist the comparison:

- [`diff`](https://en.wikipedia.org/wiki/Diff) CLI tool can compare the original and reproduced display file, if they are text-based
- [`erc-checker`](https://github.com/o2r-project/erc-checker), the tool used within the reproducibility service, can be [installed with npm](https://www.npmjs.com/package/erc-checker) and run locally to compare both texts and embedded images

#### Manipulate & substitute

You can use the bindings specified in the `erc.yml` to identify core parameters in the main file or other script files of the compendium and manually change these when compiling the document.
Alternatively you can read through all code (starting with the main file), understand it, and change it as whished.
Substitution can also be done manually by changing the file paths in the instructions loading data files.

!!! tip
    You can initialise a local code repository after extracting the download to trace your changes, e.g. with [`git diff`](https://git-scm.com/docs/git-diff).

Changing code and data is easiest when using a local environment, but also possible for the included runtime image by using bind mounts when running the image.

### Detailed examination of code and text

This guide can not go into detail about examining the actual code, data, and text content and therefore ends at this stage.
Such a detailed level of examination is domain-specific.
However, a generic guide for the consumption of (executable) research compendia is published as part of the [research-compendium.science](https://research-compendium.science/) initiative:

> _Nüst, Daniel, Carl Boettiger, and Ben Marwick. 2018. "How to read a research compendium." [arXiv:1806.09525](https://arxiv.org/abs/1806.09525) [cs.GL]._
