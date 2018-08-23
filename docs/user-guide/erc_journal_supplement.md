# User guide: the ERC as journal supplement

To facilitate integration into open access journals, the ERC can serve as a supplement to a journal article.
In that use case a supplement would not contain the full text of the publication but be attached to or linked from an article instead.
While this increases storage size (each ERC must contain all required data and software), introduces duplication (e.g. in the metadata) and spreads out related artifacts (e.g. if each supplement is stored in an independent repository item), it considerably simplifies integration with existing workflows and practices, namely by licensing and storing the supplemental material independently from the article, by not impacting the existing article rendering solution (e.g. static HTML or PDF), and by reducing the impact on the established review and production workflow.

When the ERC is attached as supplement, it is important to make sure the results are still findable, accessible, interoperable, and reusable, following the FAIR principles.
A supplemental ERC should most importantly reference the main article via its DOI.

An ERC as supplement must still be a formally complete ERC and as such it satisfies important requirements of reproducible research.

!!! tip "Example"
    A publication contains three figures with data plots.
    Two approaches are possible:
    
    - each of the figures is encapsulated in a minimal ERC containing the needed data, an R script, the rendered figure as a grphic (e.g. a PNG), and its own runtime environment; or
    - all figures are embedded in an R Markdown document, including the article abstract, figure titles, and figure description, and share data files and the runtime environment.
    
    The latter approach is more user friendly because explanatory context is provided and the HTML-based display file directly supports UI bindings.

Read more on the increasing importance of reproducible supplements scientific records in
[Greenbaum et al. 2017](https://doi.org/10.1186/s13059-017-1205-3).

If ERCs are published on data repositories or collaboration platforms, they should be tagged as `research-compendium` following the conventions of **[https://research-compendium.science/](https://research-compendium.science/)**.