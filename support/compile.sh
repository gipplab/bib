#!/usr/bin/env bash
biber --tool --configfile=src/biber/reformat.xml gipp.bib --validate-datamodel
biber --tool --configfile=src/biber/mendeley.xml gipp.bib
diff -w gipp.bib gipp_bibertool.bib || support/commitUp.sh
cd src/tex
latexmk
cp allRefs.pdf ../../main.pdf
cd ../..
python3 support/issue.py
support/pubHtml
