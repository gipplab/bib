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


## testpr from other repo
