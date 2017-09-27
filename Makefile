
.PHONY: clean build_all all xall x_build_all

clean:
	latexmk -C
	rm -f creationdate.timestamp
	rm -f creationdate.lua
	rm -f *.synctex.gz
	rm -f *.xyc
	rm -f *.xmpi

# Find all the tex files and build them
%.pdf: %.tex
	pdflatex -synctex=1 -interaction=nonstopmode $^
	pdflatex -synctex=1 -interaction=nonstopmode $^ #Since we might have bibliography and toc run it twice
	echo "[DONE]:[  $^ ] "

# Use XelateX
%.xepdf: %.tex
	xelatex -shell-escape $^
	xelatex -shell-escape $^ #Since we might have bibliography and toc run it twice
	echo "[DONE]:[  $^ ] "

# Use PdfLateX
build_all: $(addsuffix .pdf, $(basename $(wildcard *.tex)))

# Use XelateX
x_build_all: $(addsuffix .xepdf, $(basename $(wildcard *.tex)))

all: clean build_all

xall: clean x_build_all
