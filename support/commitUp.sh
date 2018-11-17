#!/usr/bin/env bash
mv gipp_bibertool.bib gipp.bib
gpg --import bibbot.asc
git config --global user.email "bibbot@ckurs.de"
git config --global user.name "BibBot"
git config --global user.signingkey "1617C27854592471"
git commit -m -S "Reformat bib file" gipp.bib
git remote add http https://bibbot:${GITHUB_TOKEN}@github.com/ag-gipp/bib.git > /dev/null 2>&1
git push http HEAD:$TRAVIS_BRANCH
