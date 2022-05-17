# Academic papers using R, knitr, make, and Docker

This repository contains template files to write reproducible academic papers
using R, knitr, make, and Docker. Click [here](paper/paper.pdf) to view the output.

The workflow is as follows:

1. Work inside the `paper` directory on the `paper.Rnw` file. Compile to a PDF
   by running from inside the `paper`` directory

``` sh
make pdf
```

2. Specify R-version in the Docker file. List all required packages from CRAN in
   the `CRANpackages.txt` file, add the packages from GitHub to the dockerfile. Run 
   from the root directory of the repository
   
``` sh
make drun
```

   to compile knit the PDF via Docker for exact reproducibility. The CRAN
   packages will be installed from a CRAN snapshot the last day the specified R
   version was up to date.

