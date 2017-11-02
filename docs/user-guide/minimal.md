# Minimal examples for ERCs

1. [R script with png plot](#r-script-with-png-plot)
1. [R Markdown with HTML output](#r-markdown-with-html-output)

## R script with png plot

### Main file `main.R`

```R
# http://www.budgetshippingcontainers.co.uk/info/
# how-many-shipping-containers-are-there-in-the-world/
containers <- c(23000000,14000000,6000000)
set.seed(42)
barplot(containers,
    names.arg = c("in service", "ex-service", "new"),
    col = sample(colors(), 3),
    main = paste0(
        format(sum(containers), scientific = FALSE),
        " containers in the world")
    )
```

### Display file `display.png`

![Minimal ERC example display.png](/img/minimal/display.png)

### ERC configuration file

```yml
---
id: "289a9jcl9o"
spec_version: "1"
main: main.R
display: display.png
```


## R Markdown with HTML output

### Main file `main.Rmd`

````markdown
---
title: "Capacity of container ships in seaborne trade from 1980 to 2016 (in million dwt)*"
author: "Daniel Nüst"
date: "2017"
output: html_document
---

```{r plot, echo=FALSE}
data <- c("1980" = 11, "1985" = 20, "1990" = 26, "1995" = 44,
          "2000" = 64, "2005" = 98, "2010" = 169, "2014" = 216,
          "2015" = 228, "2016" = 244)
barplot(data, ylab = "Capacity", sub = "© Statista 2017")
```

> This statistic portrays the capacity of the world container ship fleet from 1980 through 2016. In 2016, the world merchant container ship fleet had a capacity of around 244 million metric tons deadweight. As of January 2016, there were 5,239 container ships in the world's merchant fleet ([source](https://www.statista.com/statistics/264024/number-of-merchant-ships-worldwide-by-type/)).

Sources: UNCTAD; Clarkson Research Services, via [statista](https://www.statista.com/statistics/267603/capacity-of-container-ships-in-the-global-seaborne-trade/).
````

### Display file `display.html`

<iframe src="/img/minimal/seaborne-trade.html" width="100%" height="500" style="border: 2px solid grey;"></iframe>

**[HTML](/img/minimal/seaborne-trade.html)**

### ERC configuration file

```yml
---
id: "v97cplst6b"
spec_version: "1"
main: main.Rmd
display: display.html
```