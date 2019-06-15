# Examples to run DEICODE

### Arguments to run any of the scripts below:
- -i : Path of the input FeatureTable. E.g. /home/user/Features.tsv. Use .tsv, .qza or .biom format.
- -f : Format of FeatureTable. E.g. tsv, qza or biom (do not use dot before the format).
- -c : Column containing the row indexes for the FeatureTable. Use when FeatureTable is not .biom or .qza
- -m : Metadata file in tab-separated values format.
- -o : Path to output results
- -p : Phenotype or column name to perform PERMANOVA. Use Categorical variables. E.g. BodySite.
- -q : yes/no instruction to perform QURRO analysis

**First, activate your qiime2 (mini)conda environment. For example:**

```
conda activate qiime2-2019.1
```

**When having a .biom feature file, run thi:s**

```
# MODIFY PATH IN ROOT
ROOT=/Users/earmingol/Dropbox/Universidad/UCSanDiego/Lab_Knight/Microbiome-Factorization/
$ROOT/src/deicode/run_deicode.sh \
  -i $ROOT/data/pH_study/OTUs_table.biom \
  -m $ROOT/data/pH_study/metadata.txt \
  -o $ROOT/outputs/DEICODE/ \
  -y $ROOT/data/GreenGenes/97_otu_taxonomy.txt \
  -p soil_type \
  -q yes
```

**When having a .tsv or other table format, run this (data available after running DataPreprocessing notebook):**

```
# MODIFY PATH IN ROOT
ROOT=/Users/earmingol/Dropbox/Universidad/UCSanDiego/Lab_Knight/Microbiome-Factorization/
$ROOT/src/deicode/run_deicode.sh \
  -i $ROOT/outputs/filtered_OTUs_table.tsv \
  -c "#OTU ID" \
  -m $ROOT/outputs/filtered_metadata.txt \
  -o $ROOT/outputs/DEICODE/ \
  -y $ROOT/data/GreenGenes/97_otu_taxonomy.txt \
  -p PhClasses \
  -q yes
```

**Then, you can visualize the results of either DEICODE (deicode_biplot.qzv) or Qurro (qurro_plot_q2.qzv) loading
the respective files on the [Emperor online tool of Qiime2](https://view.qiime2.org/).