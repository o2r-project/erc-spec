# erc-spec

Executable Research Compendium (ERC) specification and guides

Project description: [https://o2r.info](https://o2r.info)

**Read online: [https://o2r.info/erc-spec](https://o2r.info/erc-spec)**

## Guidelines

See [CONTRIBUTING.md](CONTRIBUTING.md)

## Build

This specification is written in [Markdown](https://daringfireball.net/projects/markdown/), rendered with [MkDocs](http://www.mkdocs.org/) and deployed automatically using Github Actions.

![badge for workflow status](https://github.com/o2r-project/erc-spec/actions/workflows/deploy_site.yml/badge.svg)

Use `mkdocs` to render it locally.

```bash
# pip install mkdocs mkdocs-cinder pymdown-extensions
mkdocs serve
```

### Automated Builds

Our `deploy_site.yml` will run the `mkdocs` command on every direct commit or merge on the master branch and deploy the rendered HTML documents to the `gh-pages` branch in this repository.

The action authenticates its push to the `gh-pages` branch using the [checkout action](https://github.com/actions/checkout) and the credentials of the user [@o2r-user](https://github.com/o2r-user), who has write access to this repository. It is finalized through the [github pages deploy action](https://github.com/marketplace/actions/deploy-to-github-pages).

## License

The o2r Executable Research Compendium specification is licensed under [Creative Commons CC0 1.0 Universal License](https://creativecommons.org/publicdomain/zero/1.0/), see file `LICENSE`.
To the extent possible under law, the people who associated CC0 with this work have waived all copyright and related or neighboring rights to this work.
This work is published from: Germany.
