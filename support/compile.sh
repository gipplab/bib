#!/usr/bin/env bash
biber --tool --configfile=src/biber/reformat.xml gipp.bib --validate-datamodel
diff -w gipp.bib gipp_bibertool.bib || support/commitUp.sh && exit 1
cd src/tex
latexmk
cp allRefs.pdf ../../main.pdf
cd ../..
python3 support/issue.sh
