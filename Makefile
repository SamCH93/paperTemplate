all: dbuild drun

FILE = paper

## running R within docker, but LaTeX outside
## -----------------------------------------------------------------------------
## build docker image (requires root access for docker)
dbuild: Dockerfile
	docker build \
    -t $(FILE) .

## run docker image that produces tex from within docker
drun: dbuild
	docker run \
    --rm \
	-v $(CURDIR):/output \
		$(FILE)
## compile pdf using LaTeX outside docker
	mv paper.tex paper/paper.tex
	mkdir -p paper/figure
	mv figure/* paper/figure
	rmdir figure/
	cd paper && make pdf2 clean

# TODO implement working switch for PDF compilation inside/outside docker
# ## running R and LaTeX within docker (installing LaTeX packages takes a while...)
# ## -----------------------------------------------------------------------------
# ## build docker image (requires root access for docker)
# dbuildpdf: Dockerfile
# 	docker build \
# 	--build-arg pdfdocker="False" \
# 	-t $(FILE) .

# ## run docker image that produces pdf from within docker
# drunpdf: dbuild
# 	docker run \
#     --rm \
# 	--volume $(CURDIR):/output \
# 		$(FILE)
# 	mv paper.pdf paper/paper.pdf
