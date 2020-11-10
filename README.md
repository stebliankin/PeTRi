# PeTRi

<b>PeTRi</b> is a pipeline that combines efficient cluster computation of bacterial replication rates from metagenomic 
sequence data, abundance profile, resistome profile, and environmental variables to perform causality analysiss.

---### Placeholder for the figure

The pipeline consist of three modules:<br>

* [A-PTR_abundance]() - Compute PTR and microbial abundance from metagenomic samples;<br>
* [B-ABR-genes]()  Identify ABR genes present in metagenomic samples;<br>
* [C-Causality]() Apply causal inference to PTR, microbial profile, resistome profile, and clinical variables <br>

Each of the models has detailed instructions on how to run the parts of the pipeline.

## Requirments
* [Slurm](https://slurm.schedmd.com/documentation.html)
* [Python](https://www.python.org/)
* [BioPython](https://biopython.org/)
* [Pandas](https://pandas.pydata.org/)
* [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
* [iRep](https://github.com/christophertbrown/iRep)

## Publication

More information about the method can be found in the following paper:

"Improved Microbiome Analysis Using Bacterial Replication Rates and Causal Inference" - Vitalii Stebliankin, Musfiqur Sazal, Camilo Valdes, Kalai Mathee, and GiriNarasimhan (Under Review, 2020)
