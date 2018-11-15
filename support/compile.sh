#!/usr/bin/env bash
cd ../src/tex
latexmk
cp allRefs.pdf ../../main.pdf
