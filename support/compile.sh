#!/usr/bin/env bash
biber --tool --configfile=src/biber/reformat.xml gipp.bib --validate-datamodel
biber --tool --configfile=src/biber/mendeley.xml gipp.bib
diff -w gipp.bib gipp_bibertool.bib || support/commitUp.sh
cp gipp.bib src/tex
cd src/tex
docker run --rm -it --user="$(id -u):$(id -g)" -v "$(pwd)":/home adnrv/texlive:full latexmk
cp allRefs.pdf ../../main.pdf
cd ../..
python3 support/issue.py
support/pubHtml
git diff --exit-code -w docs/publist.html || support/commitPub.sh
