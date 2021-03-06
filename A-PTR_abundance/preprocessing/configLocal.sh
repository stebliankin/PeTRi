#!/bin/bash

SCRIPTS_DIR_LOCAL="path/to/PeTRi/script"
DB_LOCATION="/path/to/PeTRi/database"

THREADS=24

KRAKEN_DB_LOCAL=$DB_LOCATION"/kraken2DB"
mkdir -p $KRAKEN_DB_LOCAL
DB_PARTITIONS_LOCAL=$DB_LOCATION"/partitions"
mkdir -p $DB_PARTITIONS_LOCAL
FASTA_INDIVIDUAL_DIR_LOCAL=$DB_LOCATION"/fasta-individual"
mkdir -p $FASTA_INDIVIDUAL_DIR_LOCAL
