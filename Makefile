all: dbuild drun

FILE = paper
# BIB = bibliography
# BIBSTYLE = apalikedoiurl

# ## generate .tex file from .Rnw file with knitr
# tex: paper/$(FILE).Rnw paper/$(BIB).bib paper/$(BIBSTYLE).bst
# 	Rscript -e "knitr::knit('paper/$(FILE).Rnw')" --vanilla

# ## generate .pdf file from .tex file
# pdf: tex
# 	pdflatex paper/$(FILE)
# 	bibtex paper/$(FILE)
# 	pdflatex paper/$(FILE)
# 	pdflatex paper/$(FILE)

# ## clean tex files
# clean:
# 	rm paper/$(FILE).aux  paper/$(FILE).blg  paper/$(FILE).log \
# 	paper/$(FILE).tex  paper/$(FILE).bbl paper/$(FILE).out \
# 	paper/$(FILE).brf paper/$(FILE).tex paper/$(FILE).synctex.gz; \
# 	rm -r paper/figure/

## build docker image (requires root access for docker)
dbuild: Dockerfile
	docker build -t $(FILE) .

## run docker image (requires root access for docker)
drun: dbuild
	docker run -v $(CURDIR):/output $(FILE)
	mv -f paper.tex paper/paper.tex
# mv -f figure paper/figure
	cd paper && make pdf2
