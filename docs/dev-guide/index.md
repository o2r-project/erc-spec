# ERC developer guide

An introduction to the ERC rational and the technology choices made within the project _Opening Reproducible Research_ (o2r), and ideas for downstream products based on ERCs.
This documents is targeted at **developers** who wish to create tools for creating, validating, and consuming ERC or who wonder about why specific tools or approaches were taken in designing the ERC specification.

More information about the software developed by o2r:

- [o2r Web API specification](http://o2r.info/o2r-web-api)
- [o2r Architecture documentation](http://o2r.info/architecture/)
- [o2r Reference Implementation](https://github.com/o2r-project/reference-implementation)

!!! note
    This guide is a draft. If you have comments or suggestions please file them in the <a href="https://github.com/o2r-project/erc-spec/issues">issue tracker</a>. If you have explicit changes please fork the <a href="https://github.com/o2r-project/erc-spec">git repo</a> and submit a pull request.

## Convention over configuration and DevOps

The ERC specification is inspired by two approaches to improve development and operation of software.
First,  [_"convention  over  configuration"_](https://en.wikipedia.org/wiki/Convention_over_configuration), e.g. as  practiced  in  the Java build tool [Maven](https://books.sonatype.com/mvnref-book/reference/installation-sect-conventionConfiguration.html).

We want to create a directory structure with default file names and sensible defaults.
This way a typical research workspace should require only minimal configuration in 80% of the cases, while allowing to override each of the settings if need be and providing full customizability in the remaining 20%.

For example, the main command to compile the text manuscript in a compendium could be `knitr::knit("<*>.Rmd")`, with `<*>` being replaced by name of the first RMarkdown file.
However, if a user wants to use `rmarkdown::render(..)` on a file named `publication.md`, then the default behaviour can be overwritten.

Second, _"DevOps"_, see [Wikipedia](https://en.wikipedia.org/wiki/DevOps) or [Boettiger](https://doi.org/10.1145/2723872.2723882).
All processing and configuration shall be scripted, no "click" interaction required.

## Related initiatives, specifications, ...

- [ActivePapers](http://www.activepapers.org/)
- [eLife Reproducible Document Stack](https://elifesciences.org/labs/7dbeb390/reproducible-document-stack-supporting-the-next-generation-research-article) and the `dar` format
- [Whole Tale](http://wholetale.org/), see its [serialization format](https://github.com/whole-tale/whole-tale/issues/24)
- [REANA](https://reanahub.io) by CERN

## Reasoning and decisions

### What is the life span of an ERC?

Short answer: 10 years.

Software that is "archived" is _not_ intended to be "used" anymore.
In 50 or 60 years time we cannot imagine how software or computers will look like.
Science historians might still find a lot of valuable information in ERC, though.

The ERC focusses on providing a **usable environment for research workflows** in the context of scholarly publishing (reviews etc.).
Two aspects have an impact on the time frame we target for ERCs: (a) the nature of financing science and (b) the requirement to actually have a piece of code and data that is still interesting to use.

Financing of scientific research is normally based on projects with a specific life span.
We follow common guidelines for _publishing scientific data_, which require projects to ensure data availability for 10 years.

Although much of the software we use today (like R) is actually quite "old", we do not expect pieces of software that are relevant and useful to disappear for many years and only be preserved in ERCs.
So, valuable software will exists and be maintained outside of ERCs.
Specific software might only exist in ERCs and can be thoroughly inspected forever, but _potentially_ not be executed anymore after a decade.

We acknowledge a [half life](http://ivory.idyll.org/blog/2017-pof-software-archivability.html) of computations, but the **medium term reproducibility of ERC are already a huge improvement** over [the current state](https://doi.org/10.1016/j.cub.2013.11.014) at the example of research data.
The situation for research data might have improved in the last years, but the situation for code is mostly unknown and might be even worse.

### Notes and decisions to elaborate on...

- research workflows with environmental or generated data can be _"born digital_" from beginning and stay that way to the end (sensors, data storage, data analysis, presentation, review, publication)
- researchers do their thing and need independence/flexibility, so post-hoc creation will probably be most common and ERC must have low to no impact on workflow
- data storage, citation (for giving credit) and preservation is solved (repos, DOIs, bitstream preservation in archives)
- packaging methods/methodology for software is solved (R packages, Python packages, ...)
- software preservation is _not_ solved (methods are there, like migration, emulation, but complexity is too high to do this at high granularity)
- reproducible paper is somewhat solved (literate programming, R package dependency handling solutions, ..)
- computational RR requires sandboxing (to make sure everything is there, but also for security)
- a service is needed to create ERC for researchers and executes them in a controlled environment

### Why nested containers?

A user shall have access to the files without starting the runtime container.
Therefore we have at least two items, so we have a bundle and need an outer container.
As a bonus, the outer container can immediately be used to make an ERC conform to specific use cases, such as long term archival.
Also the chosen outer container solution (zip, tarball) is much older and common than the inner container standard, and thus more likely to exist longer.

> "What's oldest lasts longest." [source](https://github.com/swcarpentry/good-enough-practices-in-scientific-computing/blob/gh-pages/index.md#supplementary-materials)

The alternative of putting everything into the container itself (e.g. using image labels for metadata) can be evaluated in the future.

### Why BagIt?

- BagIt is something that preservation experts understand and covers what they care about (bitstream preservation), so it seemed a good fit in the first project vision.
- BagIt originally was the required packaging for uploading of data, but that has changed. Users upload their data and analysis, and then execute the analysis to ensure the output matches what they created themselves. This is more important than correct bits, which become relevant again after creation of an ERC when it is stored and a bag is created.

### What about the limitations of containers?

We are aware of the limitations that containers have.
Most importantly the operating system and the kernel are not included.
This results in smaller container size and better performance (e.g. quicker start because no "boot") and also has security advantages.
However, it also means that the encapsulated runtime environment in ERCs is _not_ "all the way down".

It must be noted that of course changes in the operating system and it's kernel may break a workflow encapsulated in a container.

Let's consider the **Linux Kernel**.
Those breaking changes are [very rare](https://www.reddit.com/r/linux/comments/3jyscd/has_there_been_a_time_when_the_linux_kernel/).

Let's consider **Docker**.
Docker containers have by now been [standardised by the OCI](https://www.opencontainers.org/release-notices/v1-0-0) and ERCs [should rely on the open standard in the future](https://github.com/o2r-project/erc-spec/issues/7) (contributions welcome).
The [maintenance lifecycle](https://success.docker.com/article/Maintenance_Lifecycle) and [compatibility matrix](https://success.docker.com/article/Compatibility_Matrix) of Docker do not imply they are suitable for the targeted time frame for ERCs.

However, all these projects are Open Source software or documentation, and a long term provider for ERC (i.e. not a small research project) can handle these limitations in different ways, for example **organisationally** with long term maintenance contracts or **technically** as outlined in the o2r architecture [in the production architecture sketch](http://o2r.info/architecture/#72-production-sketch).
These include specialised hardware and operating system specifics.

### Why Docker?

- (Docker) containers provide an encapsulation mechanism to package all dependencies of an analysis
- Docker now basically is OCI, so switching to other tools should be possible.
- during container execution, and substitution, the build in [copy-on-write](https://en.wikipedia.org/wiki/Copy-on-write) storage only creates copy of files that are changed within the container, thus saving storage capacity
- volume mounts allow easy substitution of input data and configurations of analysis

### Why not Singularity?

[Singularity](http://singularity.lbl.gov/) is an open source containerization solution.
It might very well be a better choice for reproducible research in the future as it stems from the scientific community (HPC), cf. also [C4RR workshop 2017](https://www.software.ac.uk/c4rr).
At the point of starting the specification, Docker was more widespread and implementations more readily available.
Furthermore the origin of Singularity, high performance computing, is out of scope of ERC.

We do not see an issue in not using Singulary.
Most importantly, the concepts _runtime manifest_ and _runtime image_ are abstract, i.e. independent of Docker and the concrete container tool choice could be made flexible in future versions of the specification.
Singularity can import Docker images and as such make a transition possible, or even let an implementation use Singularity without touch the specification.

### Why not just use plain R?

It would be possible to rely solely on R for replication.
For example, the runtime manifest could be a [codemeta](https://codemeta.github.io/) document, and the runtime environment is created based on it outside of the ERC when needed, for example by installing R in the required version.
Additionally a package for preserving a state of dependencies could be used, e.g. [packrat](https://rstudio.github.io/packrat/).
This solution is potentially less storage intensive, because containers replicate an R installation each time.
Smaller storages might also ease collaboration.

However, none of these solutions touches the underlying system libraries.
The complexity of preserving the runtime environment is transferred from the packaging stage to the unpackaging stage, which is unfavourable because that packaging state "everything works", so better control is ensured at that time.
The burden in a plain R solution shifts from authoring to preservation.

Even though shipping system binaries within packages is possible (if not common), some packages do use system libraries which are not preserved in a plain R approach.
Adjusting such packages is not an option.

Furthermore, none of the solutions for reproducibility are part of "core R", even if they are trustworthy (e.g. MRAN).
CRAN does not support installing specific package versions.

That is why using an abstraction layer outside of R is preferable.

### What if licensing information is not detailed enough?

Without proper license credits, the contents of an ERC would be useless based on today's copyright laws.
Therefore we rather have the extra work for authors to define a couple of licenses than to create something that is unusable by others.

One of the biggest issues is the **scope of licenses**, namely what to do about having multiple pieces of code, text, or data with different licenses.

**Ideas/Notes**

The `erc.yml` could also hold more complex license metadata, for specific directories or files.
Probably this is better solved in specialised formats, though.

!!! tip "Example using specific licenses"
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
            paper.Rmd: CC-BY-4.0
          ui_bindings: CC0-1.0
          metadata: CC0-1.0
    ```

It could even be possible to assign one license to a directory and override that assignment for a single file within that directory, or use globs or regular expressions.

### Why (not) put "X" into the ERC configuration file?

- identifier
    - makes it easier to track across platforms
    - is harder for manual creation
- kernel
    - would have to use our own label within image metadata
- os and architecture
    - are already clearly defined im image spec
    - can be extracted from a plain text file in the image tarball, so implementations can get them (quickly) before loading an image (a potentially costly operation)
- Docker version
    - is already clearly defined in image spec

### Why is validation happening outside the container and not _in_ the container?

- better user experience (otherwise all info must be transported via stdout)
- to be sure nothing is manipulated within the validation script

### Why is the data not in the image (inner container) but in the outer container?

- better accessible in the long term
- no data duplication

## ERC completeness score

While the ERC is intended to be simple enough to be created manually, the clear requirements on it's contents also serve a semi-automatic creation.
For example, a user can upload a workspace with data files, and R Markdown document, and an HTML rendering of the document to an online platform, where the runtime manifest and image are automatically created. In such a case, metadata would still be added manually.

To encourage users, especially during the manual steps of the creation process, to provide valuable input a **completeness score** can be useful.
Comparable to profile editors on social network sites, a percentage based score can be used to highlight content or aspects going beyond the mandatory requirements.

Implementing platforms may create their own rules, for example which of the optional metadata elements contribute towards reaching a full score.
Thinking beyond merely the metadata, the score could also cover the runtime manifest (e.g. does it follow common practices, include relevant independent metadata, uses explicit versioning for dependency installation), contained code (e.g. automatic checks against code formatting guidelines, syntactical errors), and contained data (e.g. are open file formats used, maybe rewarding CSV over Shapefiles).

A completeness score can be seen as a _downstream product_ based on the ERC.
It is unlikely this ever makes it into an ERC specification, but it can be a crucial means towards acceptance, adoption, and success of ERCs.