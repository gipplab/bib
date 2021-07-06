#!/usr/bin/env bash
docker run --rm -i --user="$(id -u):$(id -g)" -v "$(pwd)":/home adnrv/texlive:full biber --tool --configfile=src/biber/all/filter.xml ${1-gipp}.bib
docker run --rm -i --user="$(id -u):$(id -g)" -v "$(pwd)":/home adnrv/texlive:full biber --output-format=biblatexml --configfile=src/biber/all/clean.xml --clrmacros --tool all.bib
./support/xstlprocJ/xsltprocJ src/xsl/transform.xsl references.xml > /dev/null 2>&1
./support/xstlprocJ/xsltprocJ src/xsl/transform.xsl references.xml > all.html
cat src/html/pub_header all.html src/html/pub_footer > docs/pub${1-gipp}.html

