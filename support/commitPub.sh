#!/usr/bin/env bash
[ -z "$TRAVIS" ] && exit 1 || echo "skip commit. Travis environment variable not set."
gpg --import bibbot.asc
git config --global user.email "bibbot@ckurs.de"
git config --global user.name "BibBot"
git config --global user.signingkey "1617C27854592471"
git commit -S -m "Update publication list" docs/publist.html
git remote add http https://${GITHUB_TOKEN}@github.com/ag-gipp/bib.git
git push http HEAD:$TRAVIS_BRANCH
exit 1