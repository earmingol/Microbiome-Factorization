#!/usr/bin/env bash
# -i for input otu_table.qza
# -m for input metadata.txt or .tsv
# -t for input tree.tree
# -o for input output path
while getopts i:m:t:o:y: opt; do
  case $opt in
      i) OTU_TABLE=${OPTARG};;
      m) METADATA=${OPTARG};;
      t) TREE=${OPTARG};;
      o) OUTPUT=${OPTARG};;
      y) TAXONOMY=${OPTARG};;
  esac
done

# Import OTU table with BIOM format
if [[ $OTU_TABLE ]]
then
  qiime tools import \
    --input-path $OTU_TABLE \
    --type 'FeatureTable[Frequency]' \
    --output-path $OUTPUT$"/otu_table.qza"
  if [[ $METADATA ]]
  then
    # Summarize data
    qiime feature-table summarize \
      --i-table $OUTPUT$"/otu_table.qza" \
      --o-visualization $OUTPUT$"/metadata_table.qzv" \
      --m-sample-metadata-file $METADATA
  fi
fi

if [[ $TREE ]]
then
  # Import Tree
  qiime tools import \
    --input-path $TREE \
    --type 'Phylogeny[Rooted]' \
    --output-path $OUTPUT$"/phylogenetic_tree.qza"
fi

if [[ $TAXONOMY ]]
then
  BASE=$(basename "$TAXONOMY" | cut -d. -f1)
  # Import taxonomy
  qiime tools import \
   --type FeatureData[Taxonomy] \
   --input-path $TAXONOMY \
   --input-format HeaderlessTSVTaxonomyFormat \
   --output-path $OUTPUT$BASE$".qza"
fi
