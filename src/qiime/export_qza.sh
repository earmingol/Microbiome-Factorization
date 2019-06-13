#!/usr/bin/env bash

# Table
TABLE=${1?Error: No .qza file provided}

BASE=$(basename $TABLE .qza)
OUTPUT1=${TABLE//.qza/}
OUTPUT2=$"/"$BASE$".tsv.tmp"

qiime tools export \
--input-path $TABLE \
--output-path $OUTPUT1

biom convert \
-i $OUTPUT1$"/feature-table.biom" \
-o $OUTPUT1$OUTPUT2 --to-tsv

#awk NR\>1 $OUTPUT1$OUTPUT2 > $OUTPUT1${OUTPUT2//.tmp/}
mv $OUTPUT1$OUTPUT2 $OUTPUT1${OUTPUT2//.tmp/}
