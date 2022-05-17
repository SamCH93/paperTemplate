## set R version (https://hub.docker.com/r/rocker/verse/tags)
FROM rocker/verse:4.1

# ## should pdf be compiled within docker?
# ## by default set to FALSE in the makefile because tinytex takes ages to
# ## download and install latex packags
# ARG pdfDocker

## directories
RUN mkdir /output
RUN mkdir /analysis
COPY paper /analysis
COPY packages.txt /analysis
WORKDIR /analysis

## install R packages from CRAN the last day of the specified R version;
## add packages required for the analysis in the paper folder to run to the
## packages.txt file
RUN install2.r --error --skipinstalled --ncpus -1 \
    `cat packages.txt`

## install R packages from github (use @ for specific version/tag)
# RUN installGithub.r \
#     LucasKook/ainet@becabac

## knit Rnw to tex and compile tex outside docker to pdf
CMD Rscript -e "knitr::knit('paper.Rnw')" --vanilla \
    && mv paper.tex /output/ \
    && mkdir -p /output/figure \
    && mv figure/* /output/figure/

# ## knit Rnw to tex and compile tex inside docker to pdf
# ## compile tex to pdf inside docker via tinytex
# CMD Rscript -e "knitr::knit2pdf('paper.Rnw')" --vanilla \
#     && mv paper.pdf /output/paper.pdf
