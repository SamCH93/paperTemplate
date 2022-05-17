all: dbuild drun

FILE = paper

## build docker image (requires root access for docker)
dbuild: Dockerfile
	docker build -t $(FILE) .

## run docker image (requires root access for docker)
drun: dbuild
	docker run \
	-v $(CURDIR):/output \
	--user $(id -u):$(id -g) \
	$(FILE)
	mv -f paper.tex paper/paper.tex
	mkdir -p paper/figure
	mv -f figure/* paper/figure
	cd paper && make pdf2
