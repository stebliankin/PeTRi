#!/bin/bash

source config.sh

for ID in $(cat $SAMPLES_LIST); do
    echo "[" `date '+%m/%d/%y %H:%M:%S'` "] Quantifying AMR for ${ID}..."

    M1="${SAMPLES_DIR}/${ID}_1.fastq"
    M2="${SAMPLES_DIR}/${ID}_2.fastq"

    SAM_PATH="${SAM_DIR}/${ID}.sam"
    OUT_ABUNDANCE=$OUT_ABUNDANCE_DIR"/"$ID"-abundance.txt"

    let N_READS=$(wc -l $M1 | awk '{print $1}')/4

    echo "  [" `date '+%m/%d/%y %H:%M:%S'` "] Number of reads: ${N_READS}"

    bowtie2 --threads $THREADS --local --very-fast-local --no-discordant --no-mixed --no-unal -q \
         -x $INDEX -1 $M1 -2 $M2 > $SAM_PATH

    python3 abundance.py --SAM $SAM_PATH \
                    --COV_CUTOFF 0 \
                    --N_READS $N_READS \
                    --OUTPUT_ABUNDANCE $OUT_ABUNDANCE

    rm $SAM_PATH
done
