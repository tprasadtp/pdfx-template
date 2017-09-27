# commons
paper_type=a4
files=$(wildcard *.tex)

.PHONY: clean build_all all xall x_build_all 1ab


clean:
	latexmk -C
	rm -f creationdate.timestamp
	rm -f creationdate.lua
	rm -f *.synctex.gz
	rm -f *.xyc
	rm -f *.xmpi

%.pdf: %.tex
	pdflatex -synctex=1 -interaction=nonstopmode $^
	pdflatex -synctex=1 -interaction=nonstopmode $^ #Since we might have bibliography and toc run it twice
	echo "[DONE]:[  $^ ] "

%.xepdf: %.tex
	xelatex -shell-escape $^
	xelatex -shell-escape $^
	echo "[DONE]:[  $^ ] "

build_all: $(addsuffix .pdf, $(basename $(wildcard *.tex)))

x_build_all: $(addsuffix .xepdf, $(basename $(wildcard *.tex)))

all: clean build_all

xall: clean x_build_all
