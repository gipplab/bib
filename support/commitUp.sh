#!/usr/bin/env bash
mv gipp_bibertool.bib gipp.bib
gpg --import bibbot.asc
git config --global user.email "bibbot@ckurs.de"
git config --global user.name "BibBot"
git config --global user.signingkey "1617C27854592471"
git commit -m -S "Reformat bib file" gipp.bib
git push https://$GITHUB_TOKEN@github.com/ag-gipp/bib $TRAVIS_BRANCH
