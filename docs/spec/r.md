# R extension

How to put R-based analyses in an ERC.

## Structure

The structure within the ERC contents directory are intentionally unspecified.
However, the contents structure MAY follow conventions or be based on templates for organizing research artefacts.
If a convention is followed then it SHOULD be referenced in the ERC configuration file as a node `convention` within the `structure` section.
The node's value can be any text string which uniquely identifies a convention, but a URI or URL to either a human-readable description or technical specification is RECOMMENDED.

A non-exhaustive list of potential conventions _for R_ is as follows:

- [ROpenSci rrrpkg](https://github.com/ropensci/rrrpkg)
  - [Jeff Hollister's manuscriptPackage](https://github.com/jhollist/manuscriptPackage)
  - [Carl Boettiger's template](https://github.com/cboettig/template)
  - [Francisco Rodriguez-Sanchez's template](https://github.com/Pakillo/template)
- [Ben Marwick's template](https://github.com/benmarwick/template)

Example for using the ROPenSci rrrpkg convention:

```yml
id: b9b0099e-9f8d-4a33-8acf-cb0c062efaec
version: 1
structure:
  convention: https://github.com/ropensci/rrrpkg
```

## Main document

The ERC MUST contain one weaved document which integrates text and code and can be compiled into an interaction file.

The weaved document SHOULD have one of the following formats for executable documents:

- [RMarkdown](http://rmarkdown.rstudio.com/)
- [Sweave](http://www.statistik.lmu.de/~leisch/Sweave/)

The main document SHOULD NOT contain code that loads pre-computed results from files.

### RMarkdown

The document MUST NOT use `cache=TRUE` on any of the code chunks (see [`knitr` options](https://yihui.name/knitr/options/).
While the previously cached files (`.rdb` and `.rdx`) may be included, they should not be used during the rendering of the document.

### Sweave

The document MUST NOT use the `cacheSweave` package ([it is archived anyway](https://cran.r-project.org/package=cacheSweave).

## Fixing the environment in code

The time zone MUST be fixed to CET to allow validation of output times (potentially broken by different output formats).

```r
Sys.setenv("TZ" = "CET")
```

## Interaction file

The ERC MAY contain a document with interactive figures and control elements for interactive manipulation of the packaged computations.

The interaction file MUST have `HTML` format and SHOULD be valid [HTML5](https://www.w3.org/TR/html5/).

## Runtime container

The manifest file (Dockerfile) MUST use `R --vanilla`.

http://kbroman.org/knitr_knutshell/pages/reproducible.html
