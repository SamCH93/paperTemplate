## set R version (https://hub.docker.com/r/rocker/verse/tags)
FROM rocker/verse:4.1

# TODO implement working switch for PDF compilation inside/outside docker
# ## should PDF be compiled within docker?
# ## by default set to False because tinytex takes ages to download and install
# ## LaTeX packages, change in the makefile
# ARG pdfdocker="True"


## directories
RUN mkdir /output \
    && mkdir /analysis
COPY paper /analysis
COPY CRANpackages.txt /analysis
WORKDIR /analysis

## install R packages from CRAN the last day of the specified R version;
## add packages required for the analysis to the CRANpackages.txt file
RUN install2.r --error --skipinstalled --ncpus -1 \
    `cat CRANpackages.txt`

## install R packages from github (use @ for specific version/tag)
# RUN installGithub.r \
#     LucasKook/ainet@becabac

## knit Rnw to tex and compile tex outside docker to PDF
CMD Rscript -e "knitr::knit('paper.Rnw')" --vanilla \
    && mv paper.tex /output/ \
    && mkdir -p /output/figure \
    && mv figure/* /output/figure/ \
    && chmod -R 777 /output/

# ## knit Rnw to tex and compile tex inside docker to PDF
# CMD Rscript -e "knitr::knit2pdf('paper.Rnw')" --vanilla \
#     && mv paper.pdf /output/ \
#     && chmod -R 777 /output/

# TODO implement working switch for PDF compilation inside/outside docker
# ## compile the manuscript
# CMD if [ "$pdfdocker" = "True" ] ; then \
#     ## knit Rnw to tex and compile tex outside docker to PDF
#     Rscript -e "knitr::knit('paper.Rnw')" --vanilla \
#     && mv paper.tex /output/ \
#     && mkdir -p /output/figure \
#     && mv figure/* /output/figure/ ; \
#     else \
#     ## knit Rnw to tex and compile tex inside docker to PDF
#     Rscript -e "knitr::knit2pdf('paper.Rnw')" --vanilla \
#     && mv paper.pdf /output/paper.pdf ; \
#     fi \
#     ## change file permission of output files
#     && chmod -R 777 /output/
