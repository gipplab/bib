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

The GITHUB_TOKEN is automatically provided by GitHub Actions and does not need manual configuration.

For GPG-signed commits, the following repository secrets need to be added:
- `ENCRYPTED_125C18BB9738_KEY` - Encryption key for the GPG key
- `ENCRYPTED_125C18BB9738_IV` - Initialization vector for the GPG key

