# Docker runtime extension

This extension uses [Docker](http://docker.com/) to define, build, and store the runtime environment.

The runtime environment or image MUST be represented by a [Docker image v1.2.0](https://github.com/docker/docker/blob/master/image/spec/v1.2.md).

The runtime manifest MUST be represented by a `Dockerfile`, see [Docker builder reference](https://docs.docker.com/engine/reference/builder/), as defined in version [`1.12.x`](https://github.com/docker/docker/blob/1.12.x/docs/reference/builder.md).

## Docker image

The base directory MUST contain a [tarball](https://en.wikipedia.org/wiki/Tar_(computing)) of a Docker image as created be the command `docker save`, see [Docker CLI save command documentation](https://docs.docker.com/engine/reference/commandline/save/), as defined in version [`1.12.x`](https://github.com/docker/docker/blob/1.12.x/docs/reference/commandline/save.md).

The file SHOULD be named `image.tar`.

The output of the container during execution can be shown to the user to convey detailed information.

## Dockerfile

The base directory MUST contain a valid Dockerfile, see [Dockerfile reference](https://docs.docker.com/engine/reference/builder/).
The Dockerfile MUST contain the build instructions for the runtime environment and MUST have been used to create the image saved to the [runtime container file](#runtime-container-file) using `docker build`, see [Docker CLI build command documentation](https://docs.docker.com/engine/reference/commandline/build/), as defined in version [`1.12.x](https://github.com/docker/docker/blob/1.12.x/docs/reference/commandline/build.md).
The build SHOULD be done with the option `--no-cache=true`.

The file SHOULD be named `Dockerfile`.
Differing file names MUST be specified in the extension metadata, the exact node is left implementation-specific.

The Dockerfile MUST contain the required instruction `FROM`, which MUST NOT use the `latest` tag.

The Dockerfile SHOULD contain the instruction `MAINTAINER` to provide copyright information.

The Dockerfile MUST have an active instruction `CMD`, or a combination of the instructions `ENTRYPOINT` and `CMD`, which executes the packaged analysis.

The Dockerfile MUST NOT contain `EXPOSE` instructions.

The Dockerfile MUST contain a `VOLUME` instruction to define the mount point of the ERC within the container.
This mountpoint SHOULD be `/erc`.
If the mountpoint is different from `/erc`, the value MUST be defined in `erc.yml` in a node `execution.mountpoint`.

Example for the mountpoint configuration:

```yml
---
id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
version: 1
execution:
  mountpoint: "/erc"
```

### Metadata in container manifest - _Under development_

... use `LABEL` and `ENV` installations?

## Default control statements

The default control statements of implementing tools MUST be as shown in the following example configuration file.

```yml
id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
version: 1
execution:
  command:
    - `docker load --input image.tar`
    - `docker run -it -e TZ=CET erc:b9b0099e-9f8d-4a33-8acf-cb0c062efaec`
```

## Runtime manipulation

...

## Data exchange

...