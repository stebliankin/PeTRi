# B. ABR genes
This document describes how to run module B-ABR_genes of the PeTRi pipeline.

Before using the pipeline make sure to adjust all local directories in config.sh

### Download reference sequences
We downloaded publically available AMR genes curated by CARD
Version: 3.0.7

* Link to download: https://card.mcmaster.ca/download
* Reference paper: https://academic.oup.com/nar/article/48/D1/D517/5608993

### Index reference sequences
The references were indexed with bowtie2:

    ./1-index_AMR.sh

### Calculate relative abundance of AMR genes

To quantify relative abundance of AMR genes we aligned all samples and quantified the metagenomic reads:

    ./2-quantifyAMR.sh
For each sample, the script will create a file with quantity of ABR genes.

### Combine resistome with PTR
Combine abundance files produced from module "A-PTR_abundance"

    python3 3-combineABR.py
    
### Output
The scripts above should produce the file <i>ptr_amr.csv</i>