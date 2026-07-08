#!/usr/bin/env bash
# demo.sh — DataLad core loop on a small public dataset
#
# Demonstrates: install → get → run → rerun
# Uses a small OpenNeuro dataset as the example.
set -euo pipefail

# --- 1. Install: clone a DataLad dataset (metadata only, no large files) ---
echo "=== Step 1: datalad install (metadata only) ==="
datalad install -s https://github.com/OpenNeuroDatasets/ds000101.git ds000101-demo
cd ds000101-demo

# --- 2. Get: retrieve a subset of the actual data ---
echo "=== Step 2: datalad get (fetch specific files) ==="
datalad get sub-01/anat/sub-01_T1w.nii.gz

# --- 3. Run: wrap a trivial analysis so provenance is recorded ---
echo "=== Step 3: datalad run (record a command) ==="
datalad run -m "Compute file size summary" \
  --output summary.txt \
  -- bash -c 'wc -c sub-01/anat/sub-01_T1w.nii.gz > summary.txt'

# --- 4. Rerun: reproduce the exact same step from the recorded provenance ---
echo "=== Step 4: datalad rerun (reproduce from provenance) ==="
datalad rerun

echo "=== Done — the core loop is complete ==="
cat summary.txt
