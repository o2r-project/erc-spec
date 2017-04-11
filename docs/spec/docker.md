# Docker runtime extension

This extension uses [Docker](http://docker.com/) to define, build, and store the runtime environment.

The _runtime environment or image_ MUST be represented by a [Docker image v1.2.0](https://github.com/docker/docker/blob/master/image/spec/v1.2.md).

The _runtime manifest_ MUST be represented by a `Dockerfile`, see [Docker builder reference](https://docs.docker.com/engine/reference/builder/), as defined in version [`1.12.x`](https://github.com/docker/docker/blob/1.12.x/docs/reference/builder.md).

## Dockerfile

The base directory MUST contain a valid Dockerfile, see [Dockerfile reference](https://docs.docker.com/engine/reference/builder/).

The Dockerfile MUST contain the build instructions for the runtime environment and MUST have been used to create the image saved to the [runtime container file](#runtime-container-file) using `docker build`, see [Docker CLI build command documentation](https://docs.docker.com/engine/reference/commandline/build/), as defined in version [`1.12.x`](https://github.com/docker/docker/blob/1.12.x/docs/reference/commandline/build.md).
The build SHOULD be done with the option `--no-cache=true`.

The file SHOULD be named `Dockerfile`.
Differing file names MUST be specified in the extension metadata, the exact node is left implementation-specific.

The Dockerfile MUST contain the required instruction `FROM`, which MUST NOT use the `latest` tag.

The Dockerfile SHOULD contain the instruction `MAINTAINER` to provide copyright information.

The Dockerfile MUST have an active instruction `CMD`, or a combination of the instructions `ENTRYPOINT` and `CMD`, which executes the packaged analysis.

The Dockerfile SHOULD NOT contain `EXPOSE` instructions.

### Making data, code, and text available within container

The runtime environment image contains all dependencies and libraries needed by the code in an ERC.
Especially for large datasets, it in unfeasible to replicate the complete dataset contained within the ERC in the image.
For archival, it can also be confusing to replicate code and text, albeit them being relatively small in size, within the container.

Therefore a host directory is [mounted into a container](https://docs.docker.com/engine/reference/commandline/run/#mount-volume--v---read-only) at runtime using a [data volume](https://docs.docker.com/engine/tutorials/dockervolumes/#mount-a-host-directory-as-a-data-volume).

The Dockerfile SHOULD NOT contain a `COPY` or `ADD` command to include data, code or text from the ERC into the image.

The Dockerfile MUST contain a `VOLUME` instruction to define the mount point of the ERC base directory within the container.
This mountpoint SHOULD be `/erc`.
Implementations MUST use this value as the default.
If the mountpoint is different from `/erc`, the value MUST be defined in `erc.yml` in a node `execution.mount_point`.

Example for the mountpoint configuration:

```yml
---
id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
spec_version: 1
execution:
  mount_point: "/erc"
```

### Example Dockerfile

In this example we use a [_Rocker_](https://github.com/rocker-org/rocker) base image to reproduce computations made in R.

```Dockerfile
FROM rocker/r-ver:3.3.3
MAINTAINER o2r

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

LABEL Description="This is an ERC image." \
	info.o2r.bag.id="123456"

VOLUME ["/erc"]

ENTRYPOINT ["sh", "-c"]
CMD ["R --vanilla -e \"rmarkdown::render(input = '/erc/myPaper.rmd', output_dir = '/erc', output_format = rmarkdown::html_document())\""]
```

See also: [Best practices for writing Dockerfiles](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#run).


## Docker image

The base directory MUST contain a [tarball](https://en.wikipedia.org/wiki/Tar_(computing)), i.e. an archive file, of a Docker image as created be the command `docker save`, see [Docker CLI save command documentation](https://docs.docker.com/engine/reference/commandline/save/), as defined in version [`1.12.x`](https://github.com/docker/docker/blob/1.12.x/docs/reference/commandline/save.md).

The image MUST have a [_tag_](https://docs.docker.com/engine/reference/commandline/build/#tag-an-image--t) constructed from the string `erc:` followed by the ERC's id, e.g. `erc:b9b0099e-9f8d-4a33-8acf-cb0c062efaec`.

The name of the archive file MAY be configured in the ERC configuration file in the node `image` under the root-level node `execution`.

The default tar archive file names `image.tar`, or `image.tar.gz` if a [gzip compression is used for the archive](https://en.wikipedia.org/wiki/Tar_(computing)#Suffixes_for_compressed_files), SHOULD be used.
Implementations MUST recognize these names as the default values.

<div class="alert note" markdown="block">
Before exporting the Docker image, first [build it](https://docs.docker.com/engine/reference/commandline/build/) from the Dockerfile, including the tag, for example:

```bash
docker build --label erc=b9b0099e-9f8d-4a33-8acf-cb0c062efaec .
# TODO how to extract image ID from docker images --filter "label=erc=b9b0099e-9f8d-4a33-8acf-cb0c062efaec"
docker save $IMAGE_ID > image.tar
docker save $IMAGE_ID | gzip -c > image.tar.gz
```

Do _not_ use `docker export`, because it is used to create a snapshot of a container, which must not match the Dockerfile anymore as it may have been manipulated during a run.
</div>

## Control statements

The control statements for Docker executions comprise `load`, for importing an image from the archive, and `run` for starting a container of the loaded image.
Both control statements MUST be configured by using nodes of the same name under the root-level node `execution` in the ERC configuration file.
Based on the configuration, an implementation can construct the respective run-time commands, i.e. [`docker load`](https://docs.docker.com/engine/reference/commandline/load/) and [`docker run`](https://docs.docker.com/engine/reference/run/), using the correct image file name and further parameters (e.g. performance control options).

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

<div class="alert note" markdown="block">
The Docker CLI commands constructed based on this configuration by an implementing service could be as follows:

```bash
docker load --input image.tar
docker run -it --name run_abc123 -e TZ=CET -v /storage/erc/abc123:/erc --label user:o2r erc:b9b0099e-9f8d-4a33-8acf-cb0c062efaec
```

In this case the implementation uses `-it` to pass stdout streams to the user and adds some metadata using `--name` and `--label`.
</div>

The only option for `load` is `quiet`, which may be set to Boolean `true` or `false`.

```yml
execution:
  load:
    quiet: true
```

The only option for `run` is `environment` to set environment variables inside containers as defined in [docker-compose](https://docs.docker.com/compose/environment-variables/#setting-environment-variables-in-containers).
Environment variables are defined as a list seperated by `=`.


```yml
execution:
  run:
    environment:
	  - DEBUG=1
	  - TZ=CET
```

The environment variables SHOULD be used to fix settings out of control of the contained code that can hinder successful ERC checking, e.g. by setting a time zone to avoid issues during checking.

The output of the container during execution MAY be shown to the user to convey detailed information to users.
