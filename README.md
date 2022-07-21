# Template for scientific papers using R + knitr + make + Docker workflow

This repository contains template files to write reproducible academic papers
using R, knitr, make, and Docker. Click [here](paper/papername.pdf) to view the
output.

There are two ways to work on a paper: 

1. Work inside the `paper` directory on the `paper.Rnw` file using your local R
   version and packages, LaTeX installation and other dependencies. Compile the
   `paper.Rnw` file to a PDF by running the following command from inside the
   `paper` directory

``` bash
make pdf
```

   This type of workflow is suited for the initial stage of research (exploratory,
   collaborative, prototyping).


2. Work on the same `paper.Rnw` file but compile it to a PDF from inside a
   Docker container which precisely encapsulates the computational environement.
   This requires Docker (with root rights, otherwise change the Makefile).
   Specify R version in the Docker file. R packages from CRAN will then be
   installed from a CRAN snapshot the last day the specified R version was up to
   date. List all required packages from CRAN in the `CRANpackages.txt` file,
   packages from GitHub can be added to the Dockerfile. Since downloading all
   necessary LaTeX packages can take a while, the default option is do all the R
   work inside the Docker but compile the resulting `paper.tex` with a local
   LaTeX installation. This is achieved by running the following command from
   the root folder of the repository
   
``` bash
make drun
```
   
   If you want to also run LaTeX from within docker, use instead
   
``` bash
make drunpdf
```
   
   This type of workflow is suited for long-term reproducibility, at a later
   stage of research, for example, before submitting the manuscript to a
   preprint server.


## ToDo

- [ ] One file to declare variables (name of files, R version, etc.)
- [ ] Add .renv support?
