#!/usr/bin/env bash
echo "CI: $CI, GitHub Actions: $GITHUB_ACTIONS, Run ID: $GITHUB_RUN_ID"
# Support both Travis and GitHub Actions
if [ -z "$TRAVIS" ] && [ -z "$GITHUB_ACTIONS" ]; then
  echo "skip commit. CI environment variable not set."
  exit 1
fi
gpg --import bibbot.asc
git config --global user.email "bibbot@ckurs.de"
git config --global user.name "BibBot"
git config --global user.signingkey "1617C27854592471"
git commit -S -m "Update publication list" docs/publist.html
# Use GitHub Actions branch reference if available, otherwise use Travis
BRANCH=${GITHUB_REF_NAME:-$TRAVIS_BRANCH}
git remote add http https://${GITHUB_TOKEN}@github.com/gipplab/bib.git
git push http HEAD:$BRANCH
exit 1
