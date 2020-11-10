#!/bin/bash

source config.sh

OUTPUT_DIR=$INDEX
mkdir -p $OUTPUT_DIR

INDEX_NAME="AMR"

echo ""
echo "[" `date '+%m/%d/%y %H:%M:%S'` "]"
echo "[" `date '+%m/%d/%y %H:%M:%S'` "] Starting indexing..."
echo "[" `date '+%m/%d/%y %H:%M:%S'` "]"


bowtie2-build -f --threads $THREADS $FASTA_FILE $OUTPUT_DIR"/"$INDEX_NAME

echo "[" `date '+%m/%d/%y %H:%M:%S'` "] Done indexing."
