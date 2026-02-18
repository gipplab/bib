# bib ![Build Status](https://github.com/ag-gipp/bib/actions/workflows/build.yml/badge.svg)
This repo contains publications from ag-gipp.
Biblography

## Reformat the [main bib file](gipp.bib) commit
Run
```
biber --tool --configfile=src/biber/reformat.xml gipp.bib
```
this will create a new file
gipp_bibertool.bib
compare the contents of both files and overwrite `gipp.bib` with
`gipp_bibertool.bib`.

## Automatic release configuration
See the [GitHub Actions documentation](https://docs.github.com/en/actions/deployment/releasing/releasing-automatically-with-github-actions) to understand the release section of the [GitHub Actions workflow](.github/workflows/build.yml)

For the interaction with GitHub independently from GitHub Actions, we create
a [personal access token](https://github.com/settings/tokens) and make 
it available as repository secret named `GITHUB_TOKEN`.

