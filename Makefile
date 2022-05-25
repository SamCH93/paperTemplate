all: dbuild drun

FILE = paper # specify same name as in paper/Makefile

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
	mv $(FILE).tex paper/$(FILE).tex
	mkdir -p paper/figure
	mv figure/* paper/figure
	rmdir figure/
	cd paper && make pdf2 clean

## run docker image that produces pdf from within docker
drunpdf: dbuild
	docker run \
    --rm \
	--env pdfdocker="true" \
	--volume $(CURDIR):/output \
	$(FILE)
	mv $(FILE).pdf paper/$(FILE).pdf
