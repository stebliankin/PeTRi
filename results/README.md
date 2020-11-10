# Results

This directory contains results from the paper <br>
Vitalii Stebliankin, Musfiqur Sazal, Camilo Valdes, Kalai Mathee, and GiriNarasimhan. 
 <b>Novel Approach for Microbiome Analysis Using Bacterial Replication Rates and Causal Inference to Determine Resistome Potential.
 </b>
 Under Review. 2020;
 
### Data

##### Metadata
* <b>metadata</b> - metadata about samples and reference genomes

##### Output from PeTRi run based on <i>Gibson et al.</i> samples (BioProject ID: PRJNA301903):
* <b>A-out</b>: output from the PeTRi module "A-PTR_abundance" 
((#TODO:add link));
* <b>B-out</b>: output from the PeTRi module "B-ABR_genes";
(#TODO:add link));
* <b>C-out</b>: output from the PeTRi module "C-Causality";
((#TODO:add link));


#### Obtaining results described in the paper
* <b>1-FilteringPTR.ipynb</b> - Jupyter notebook for filtering outliers, averaging PTR to species level,
                                and selecting the most abundant species;<br>
 <b> analysis-out/1-FilteringPTR </b> - output from the "1-FilteringPTR.ipynb"

* <b>2-CorrelationPTR-Abundanc.ipynb</b> - Jupyter notebook for obtaining Spearman correlation between PTR and abundance.
 To visualize the correlation through heatmap (Fig. 2A in the main manuscript) run the following R script:


    Rscript R-scripts/heatmap-PTR-abundance.R

* <b>3-Divide_High-Low.ipynb</b> Stratify the dataset into "low" and "high" abundant bacteria 
<br> To generate figure 2 B-C, run the R script 

    
    Rscript R-scrupts/boxplot-antibiotics.R
    
    
* <b>4-Select_major_ABR.ipynb</b> - select ABR genes that present in at least 5% of the study samples.
The output of this notebook is file `analysis-out/4-Select_major_ABR/PTR_species_filtered_metadata_major.csv` 
which were used to run causal analysis in PeTRi module `C-Causality`

