#!/usr/bin/env bash
# -i for input otu_table.qza
# -m for input metadata.txt or .tsv
# -t for input tree.tree
# -o for input output path
while getopts i:m:t:o:d: opt; do
  case $opt in
      i) OTU_TABLE=${OPTARG};;
      m) METADATA=${OPTARG};;
      t) TREE=${OPTARG};;
      o) OUTPUT=${OPTARG};;
      d) DEPTH=$OPTARG;;
  esac
done

if [[ ! $DEPTH ]]
then
  DEPTH=1
  echo $"DEPTH="${DEPTH}
fi

# CORE ANALYSES (DIVERSITY METRICS)
qiime diversity core-metrics-phylogenetic \
  --i-phylogeny $TREE \
  --i-table $OTU_TABLE \
  --p-sampling-depth $DEPTH \
  --m-metadata-file $METADATA \
  --output-dir $OUTPUT$"core-metrics-results"

# ALPHA
qiime diversity alpha-group-significance \
  --i-alpha-diversity $OUTPUT$"core-metrics-results/faith_pd_vector.qza" \
  --m-metadata-file $METADATA \
  --o-visualization $OUTPUT$"core-metrics-results/faith-pd-group-significance.qzv"

qiime diversity alpha-group-significance \
  --i-alpha-diversity $OUTPUT$"core-metrics-results/evenness_vector.qza" \
  --m-metadata-file $METADATA \
  --o-visualization $OUTPUT$"core-metrics-results/evenness-group-significance.qzv"
