# ERC specification

An Exectuable Research Compendium (ERC) is a packaging convention for computational research.
It provides well-defined structure for data, code, documentation, and control of a piece of research and is suitable for long-term archival.

<div class="alert note" markdown="block">
This is a draft specification. If you have comments or suggestions please file them in the <a href="https://github.com/o2r-project/erc-spec/issues">issue tracker</a>. If you have explicit changes please fork the <a href="">git repo</a> and submit a pull request.
</div>

## Table of contents

- [Introduction](index.md)
  - [Notational conventions](#notational-conventions)
  - [Purpose](#purpose)
  - [Fundamental concepts](#fundamental-concepts)
- [Structure](structure.md)
- [Mounting data](mounts.md)
- [Security](security.md)
- [BagIt Profile](bagit.md)
- [R extension](structure.md)
- Glossary

## Notational conventions

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" are to be interpreted as described in [RFC 2119][rfc2119].

The key words "unspecified", "undefined", and "implementation-defined" are to be interpreted as described in the [rationale for the C99 standard][c99-unspecified].

[c99-unspecified]: http://www.open-std.org/jtc1/sc22/wg14/www/C99RationaleV5.10.pdf#page=18
[rfc2119]: http://tools.ietf.org/html/rfc2119
[issues]: https://github.com/o2r-project/erc-spec/issues
[repo]: https://github.com/o2r-project/erc-spec

## Purpose

This specification defines a well defined structure to carry and execute simple virtual machines. BagIt is an Internet-Draft standard originating from library sciences. It allows to store and transfer arbitrary content along with minimal metadata as well as payload validation. The extension lets a BagIt bag contain scientific data, executables needed to replicate an analysis, and the outputs of the original analysis, so that computational research can be collected in a self-contained fashion, transferred, archived, reproduced, and validated.

## Fundamental concepts

The bagtainer specification is inspired by two approaches to improve development and operation of software.

runtime container (inner)
erc level
outer container (bagit, research object)

## How to interact with a bagtainer?

The interaction steps with a bagtainer to (re-)run the contained analysis are as follows:

- (if compressed) open the bag
- execute the container
- (automatically) compare the output contained in the bag with the just created new output
