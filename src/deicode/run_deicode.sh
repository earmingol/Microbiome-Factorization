#!/usr/bin/env bash
# -i for input otu_table.tsv or other
# -f format for input_otu
# -c index_col of the table
# -m for input metadata.txt or .tsv
# -o for input output path
# -p for phenotype to compare with PERMANOVA
# -q boolean to run qurro
while getopts i:c:m:o:y:p:q: opt; do
  case $opt in
      i) OTU_TABLE=${OPTARG};;
      c) IDXCOL=${OPTARG};;
      m) METADATA=${OPTARG};;
      o) OUTPUT=${OPTARG};;
      y) TAXONOMY=${OPTARG};;
      p) PHENOTYPE=${OPTARG};;
      q) QURRO=${OPTARG};;
  esac
done

OUTPUT=$OUTPUT
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
parentdir="$(dirname ${dir})"
OTUEXT="${OTU_TABLE##*.}"
METAEXT="${METADATA##*.}"

# CONVERT OTU_TABLE INTO QZA TABLE
if [[ $OTU_TABLE ]] && [ $OTUEXT != "qza" ]
then
    if [ $OTUEXT != "biom" ]
    then
        python $parentdir$"/io/table2biom.py" "$OTU_TABLE" "$IDXCOL" "$OTUEXT" "$OUTPUT"
        # BIOM LOCATION
        OTU_TABLE=$(echo "$OTU_TABLE" | sed "s/.${OTUEXT}/.biom/")
        BASE=$(basename -- $OTU_TABLE)
        OTU_TABLE=$OUTPUT$"/"$BASE
    fi

    if [[ $METADATA ]]  && [ $METAEXT != "qza" ]
    then
        $parentdir$"/qiime/import_data.sh" \
          -i $OTU_TABLE \
          -m $METADATA \
          -o $OUTPUT
    else
        $parentdir$"/qiime/import_data.sh" \
          -i $OTU_TABLE \
          -o $OUTPUT
    fi
    OTU_TABLE=$OUTPUT$"/otu_table.qza"
fi

# IMPORT TAXONOMY
TAXEXT="${TAXONOMY##*.}"

if [ $TAXEXT != "qza" ]
then
  $parentdir$"/qiime/import_data.sh" \
    -y $TAXONOMY \
    -o $OUTPUT

  BASE=$(basename "$TAXONOMY" | cut -d. -f1)
  TAXONOMY=$OUTPUT$BASE$".qza"
fi

# RUN DEICODE
qiime deicode rpca \
  --i-table $OTU_TABLE \
  --p-min-feature-count 0 \
  --p-min-sample-count 0 \
  --o-biplot $OUTPUT$"/deicode_ordination.qza" \
  --o-distance-matrix $OUTPUT$"/deicode_distance.qza"


# VISUALIZE RESULTS
qiime emperor biplot \
  --i-biplot $OUTPUT$"/deicode_ordination.qza" \
  --m-sample-metadata-file $METADATA \
  --m-feature-metadata-file $TAXONOMY \
  --o-visualization $OUTPUT$"/deicode_biplot.qzv" \
  --p-number-of-features 8

# BETA DIVERSITY
if [[ $PHENOTYPE ]]
then
    qiime diversity beta-group-significance \
      --i-distance-matrix $OUTPUT$"/deicode_distance.qza" \
      --m-metadata-file $METADATA \
      --m-metadata-column $PHENOTYPE \
      --p-method permanova \
      --o-visualization $OUTPUT$"/PERMANOVA_"$PHENOTYPE$".qzv"
fi

# QURRO
if [ $QURRO == "yes" ]
then
    qiime qurro unsupervised-rank-plot \
      --i-ranks $OUTPUT$"/deicode_ordination.qza" \
      --i-table $OTU_TABLE \
      --m-sample-metadata-file $METADATA \
      --m-feature-metadata-file $TAXONOMY \
      --o-visualization $OUTPUT$"/qurro_plot_q2.qzv"
fi
