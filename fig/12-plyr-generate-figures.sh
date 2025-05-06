#! /bin/bash

pdflatex -shell-escape 12-plyr-fig1.tex

rm 12-plyr-fig1.aux 12-plyr-fig1.log 12-plyr-fig1.pdf

pdflatex -shell-escape 12-plyr-fig2.tex

rm 12-plyr-fig2.aux 12-plyr-fig2.log 12-plyr-fig2.pdf

