#!/bin/bash

# Gibson:
FASTA_FILE="path/to/downloaded/fasta/nucleotide_fasta_protein_homolog_model.fasta" # Make sure to download this file before using the pipeline

INDEX="/path/to/bwt2_index/" #will be computed in "1-index_AMR"
THREADS="32"
SAMPLES_DIR="path/to/samples"
SAMPLES_LIST="path/to/sra_list.txt"

OUT_ABUNDANCE_DIR="path/to/AMR-abundance"

SAM_DIR="path/to/SAM/alignment/file"
mkdir -p $SAM_DIR
