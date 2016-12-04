#!/bin/bash

SRC="$1"
DEST="$2"

cat "$SRC" |\
sed -e 's/\\label[{][^}]\+[}]//g; s/\\pageref[{][^}]\+[}]/FIXME:pageref/g' |\
sed 's/"-/-/g' |\
sed -e 's/\\begin{quotation}/\\begin{quote}/g; s/\\end{quotation}/\\end{quote}/g' |\
sed 's/\\QA[{]\([^}]\+\)[}]/\\textbf{\1}/g' |\
sed 's/\\cite[{]\([^}]\+\)[}]/FIXME:cite:\1/g' |\
pandoc --smart --normalize --from=latex --to=markdown |\
sed 's/\([^\\]\)\\$/\1\\\\/' > "$DEST"

