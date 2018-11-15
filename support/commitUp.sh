#!/usr/bin/env bash
mv gipp_bibertool.bib gipp.bib
git config --global user.email "bibbot@ckurs.de"
git config --global user.name "BibBot"
git commit -m "Reformat bib file" gipp.bib
git push https://$GITHUBKEY@github.com/ag-gipp/bib $TRAVIS_BRANCH
