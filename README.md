# bib [![Build Status](https://travis-ci.com/ag-gipp/bib.svg?branch=master)](https://travis-ci.com/ag-gipp/bib)
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
See the [travis manual](https://docs.travis-ci.com/user/deployment/releases/) to understand the release section of the [travis config](.travis.yml)

For the interaction with GitHub independently from travis, we create
a [personal access token](https://github.com/settings/tokens) and make 
it available as environment variable 
```bash
travis encrypt GITHUB_TOKEN=<paste PAT> --add
```

