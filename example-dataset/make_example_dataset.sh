#!/usr/bin/env bash
# make_example_dataset.sh — Create a minimal DataLad dataset with dummy files
#
# This is a post-talk reference for participants who want to try DataLad locally.
set -euo pipefail

if ! command -v datalad &>/dev/null; then
  echo "DataLad is not installed — skipping example dataset creation."
  echo ""
  echo "To install DataLad:"
  echo "  pip install datalad"
  echo "  # Also needs git-annex: sudo apt install git-annex"
  echo ""
  echo "See https://handbook.datalad.org/en/latest/intro/installation.html"
  exit 0
fi

DATASET_NAME="my-first-dataset"

echo "Creating example DataLad dataset: ${DATASET_NAME}"
datalad create "${DATASET_NAME}"
cd "${DATASET_NAME}"

# Add some tiny dummy files
echo "subject,age,score" > participants.tsv
echo "sub-01,25,0.87" >> participants.tsv
echo "sub-02,31,0.92" >> participants.tsv

mkdir -p sub-01 sub-02
echo "placeholder T1w data for sub-01" > sub-01/T1w.txt
echo "placeholder T1w data for sub-02" > sub-02/T1w.txt

datalad save -m "Add participant data and dummy imaging files"

echo ""
echo "Done. Dataset created at: ${DATASET_NAME}/"
echo "Try: cd ${DATASET_NAME} && git log"
