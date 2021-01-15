.SUFFIXES: .tex .dvi .ps .fig .eps .gnu .c
PDF = ps2pdf -dMaxSubsetPct=100 -dCompatibilityLevel=1.2 -dSubsetFonts=true -dEmbedAllFonts=true
CFLAGS  =  -Wall -g -Os -march=i686 -mpreferred-stack-boundary=2 -I/usr/local/include
CC =	gcc
LDFLAGS = -lm
.c:
	$(CC) -o $@ $(CFLAGS) $< $(LDFLAGS)


all: 	paper

paper: main.tex
	pdflatex --shell-escape main
	pdflatex main
	cp main.pdf ~/
	open -a Preview.app main.pdf

	
# tr: techreport.tex
# 	pdflatex --shell-escape techreport 
# 	pdflatex techreport 
#	scp paper.pdf nescafe:~/Desktop/esys19-paper.pdf
#	gnome-open paper.pdf >out.out 2>err.err 

#	bibtex paper


#	dvips -Pdownload35 -t letter -o paper.ps paper.dvi
#	$(PDF) paper.ps

#	bash -c 'if [[ -f .Zheng ]]; then acroread paper.pdf; else ggv paper.ps; fi'
#	dvips -Pcmz  -t letter -o paper.ps paper.dvi
#	dvips -Pcmz  -t letter -o paper.ps paper.dvi
#	bibtex paper
#	sed -e 's/\(\\begin{thebibliography}{.*}\$\)/\1\\medskip/g' paper.bbl > paper.bbl.mv && mv paper.bbl.mv paper.bbl

bib:	
	pdflatex main
	bibtex main
	bibtex main
	pdflatex main
#	pdflatex techreport
#	bibtex techreport 
#	bibtex techreport 
#	pdflatex techreport

sub:
	./submit.sh

aj: paper
	scp paper.pdf nescafe:~/Desktop/esys19-paper.pdf
	#scp paper.pdf sp13:~/Desktop/CN18-paper.pdf
clean:
	rm -rRf *.dvi *.aux *.blg *.log *.ps *~ *.bbl *.pdf

cleanmajor: clean
	rm -rRf *.out
fresh : clean bib paper

freshaj : fresh aj 
	#scp paper.pdf nescafe:~/Desktop/CN18-paper.pdf
	#scp paper.pdf sp13:~/Desktop/CN18-paper.pdf
techreport: tr
