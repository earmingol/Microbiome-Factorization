# Notebooks with the analyses done during Lab Rotation

**Run the analysis by executing the notebook's codes in the following order:**

- Run codes in [DataPreprocesing-pH notebook](DataPreprocessing-pH.ipynb) to generate the dataset used by
the analyses. This includes filtering steps and train-test splitting.

- Run codes in [PhyloFactorization-pH notebook](PhyloFactorization-pH.ipynb) to run the PhyloFactor analysis
and generate the outputs in the respective path.

- Run codes in [Plotting-PhyloFactor-pH notebook](Plotting-PhyloFactor-pH.ipynb) to generate the figures
from PhyloFactor analysis. This includes boxplots for ILR abundances in each Factor, significant factors
highlighted in the phylogenetic tree and a heatmap showing them according to samples sorted by phenotype values.

- Finally, generate the PR Curves for the predictive models suing the [PrecisonRecallCurve-pH](PrecisionRecallCurve-pH.ipynb).
This uses the results from PhyloFactor and generates a new RandomForest model using the sklearn implementation.