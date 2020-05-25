# PeTRi

<b>PeTRi</b> is a pipeline to efficiently calculate bacterial replication rates from metagenomic studies with [Slurm](https://slurm.schedmd.com/)  resource management system. 
Parallelization is achieved by partitioning the reference database such that each computational node works with its own subset of bacterial genomes.

It consists of 3 parts:
1) Alignment of metagenomic samples against subset of reference genomes with [bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
2) Abundance calculation and genome filtering;
3) Calculating bacterial replication rates with [bPTR](https://github.com/christophertbrown/iRep) software.

More information about the method can be found in the following paper:

"Improved Microbiome Analysis Using Bacterial Replication Rates and Causal Inference" - Vitalii Stebliankin, Musfiqur Sazal, Camilo Valdes, Kalai Mathee, and GiriNarasimhan (Under Review, 2020)

## Requirments
* [Slurm](https://slurm.schedmd.com/documentation.html)
* [Python](https://www.python.org/)
* [BioPython](https://biopython.org/)
* [Pandas](https://pandas.pydata.org/)
* [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
* [iRep](https://github.com/christophertbrown/iRep)

## How To Get Started
#### 1) Make sure all requirements specified above are satisfyied;
#### 2) Download current repository:

  `git clone https://github.com/stebliankin/Slurm-PTR`
 
#### 3) Preprocessing
On this step you will need to download the reference database, partition it, and index with [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml) software.
Go to "preprocessing" folder for more details

#### 4) Set up config file

Modify config file "config.sh".
You should indicate all directories and parameters necessary for computations:

Main Directories:
* SCRIPTS_DIR - path to the current repository
* TMP_SCRIPTS_DIR - directory where to keep temporary files
* LOGS_DIR - directory where to place log files from each computational task
* PROJECT_DIR - directory with results

Input Samples:
* SAMPLES_DIR - directory with WGS samples to analyze
* M1_AFFIX - affix for the first mate of WGS sample (ex. "_1.fastq")
* M2_AFFIX - affix for the second mate of WGS sample (ex. "_2.fastq")
* SAMPLES_FILE - file with listed accession numbers of samples to analyze

Database specific (see step 4 on how to build the database):
* PETRI_DB - path to partitioned database (see step 3)

Applications:
* BOWTIE2_APP - path to installed [bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
* THREADS - number of threads to use in each computational node

Slurm Credentials:
* SLURM_ACC - Slurm account name
* SLURM_QOS - Slurm QOS credentials

#### 5) Set up your Slurm account credentials:

Modify lines 4-5 in file "template-Slurm.sh" and specify your account name and QoS in the Slurm system.

#### 6) Run Slurm-PTR:

`./runSlurm-PTR.sh /absolute/path/to/config.sh`

### Output:
In specified $PROJECT_DIR you wil find two files: <i>merged_ptr.txt</i> with computed bacterial replication rates for each sample, and <i>merged_abundance.txt</i> with estimated relative abundance for each bacterial genome in all samples.
