# Factorization of microbiome datasets

This repo was created to exemplify how to use two factorization methods on microbiome datasets. The codes
of these examples were generated during my lab rotation at Rob Knight's Lab - Spring 2019.

**Here, you can find examples of using [PhyloFactor](https://github.com/reptalex/phylofactor) and
 [DEICODE](https://github.com/biocore/DEICODE) to analyze a 
 [previously published study](https://aem.asm.org/content/75/15/5111).**
 
## Requirements
- [Follow this guide about installing Qiime2](https://docs.qiime2.org/2019.4/install/) (miniconda or anaconda are required).
- [Follow this guide about installing PhyloFactor and an environment for R](./PhyloFactor-Installation.pdf). 
For more info, [check the original repo](https://github.com/reptalex/phylofactor) and 
[this tutorial](https://docs.wixstatic.com/ugd/0119a1_099ae20df8424af9a38585dcebc0d45a.pdf).
- [Follow the original instructions about installing DEICODE](https://github.com/biocore/DEICODE).
- [Follow the original instructions about installing Qurro](https://github.com/fedarko/qurro).

## Examples
- The datasets used in the examples are available in the [data folder](./data/).
- Data preprocessing used before the factorization methods is available in 
[this notebook](./notebooks/DataPreprocessing-pH.ipynb).
- To execute PhyloFactor and generate predictive models, see examples in the [notebooks folder](./notebooks/).
- To execute DEICODE + Qurro, [follow these instructions](./src/deicode/).