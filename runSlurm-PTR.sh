#!/bin/bash
# Objective:
#   The purpose of this script is to run Slurm-PTR on multiple samples
#
# All parameters are described in the file "config.sh" of this directory
#
# Author:
#   Vitalii Stebliankin (vsteb002@fiu.edu)

#-----------------------------------------------------------------------------------------------------------------------
# Directories
#-----------------------------------------------------------------------------------------------------------------------


CONFIG_PATH=$1
source $CONFIG_PATH

# Directory where to write new temporary scripts:
mkdir -p $TMP_SCRIPTS_DIR
mkdir -p $LOGS_DIR

# Path to template LSF script:
TEMPLATE_SCRIPT=$SCRIPTS_DIR"/template-Slurm.sh"

if [ -z "$2" ]
	then
	PARTITIONS="64"
else
	PARTITIONS=$1
fi

#-----------------------------------------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------------------------------------
# Scripts creation
#-----------------------------------------------------------------------------------------------------------------------


SAMPLES_ARRAY=$(cat $SAMPLES_FILE)
oneVar="1"

for SAMPLE in ${SAMPLES_ARRAY[@]}; do
  # Creating Directories:
  LOGS_DIR_SAMPLE=$LOGS_DIR"/"$SAMPLE

  mkdir -p $LOGS_DIR"/"$SAMPLE

  SCRIPT_NAME=$TMP_SCRIPTS_DIR"/"$SAMPLE"_metaPTR.sh"
  rm -f $SCRIPT_NAME


  NEW_SCRIPT=`sed s@LOGS_DIR_PLACEHOLDER@$LOGS_DIR_SAMPLE@g $TEMPLATE_SCRIPT | \
  				sed s@PARTITIONS_PLACEHOLDER@$PARTITIONS@g | \
              sed s@CONFIG_PLACEHOLDER@$CONFIG_PATH@g | \
              sed s@SAMPLE_PLACEHOLDER@$SAMPLE@g`

  echo "$NEW_SCRIPT" >> $SCRIPT_NAME
  chmod ug+rwx $SCRIPT_NAME
  echo "Script for sample ${SAMPLE}: ${SCRIPT_NAME}"

   PTR_submit=$(sbatch --account=$SLURM_ACC --qos=$SLURM_QOS $SCRIPT_NAME)
   echo $PTR_submit
   PTR_JID=$(echo $PTR_submit | awk -F' ' '{print $4}')
   if [ "$oneVar" = "1" ]; then
       ALL_JOBS=$PTR_JID
       oneVar="2"
   else
       ALL_JOBS=$ALL_JOBS":"$PTR_JID
   fi
done

echo "All jobs:"$ALL_JOBS

# Submit combining all partitions
sbatch -J combinePTR \
        --account=$SLURM_ACC \
        --qos=$SLURM_QOS \
        -N 1 \
        -p centos7 \
        -n 1 \
        -o $LOGS_DIR"/stdout-combine.txt" \
        -e $LOGS_DIR"/stderr-combine.txt" \
        ${SCRIPTS_DIR}/modules/4-combine_results.sh $CONFIG_PATH
       # --dependency=afterok:$ALL_JOBS \
        ${SCRIPTS_DIR}/modules/4-combine_results.sh $CONFIG_PATH
