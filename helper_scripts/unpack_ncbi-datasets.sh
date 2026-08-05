#!/bin/bash

ZIPFILE=$(ls ncbi_dataset*.zip 2>/dev/null | head -1)
TMPDIR=$(mktemp -d)

if [ -z "$ZIPFILE" ]; then
    echo "No NCBI datasets ZIP file found."
    exit 1
fi

# Remove previous extraction if it exists
rm -rf ncbi_dataset

echo "Extracting $ZIPFILE..."
unzip -q "$ZIPFILE" -d "$TMPDIR"

echo "Moving FASTA file(s)..."
find "$TMPDIR/ncbi_dataset/data" -type f \( \
    -name "*.fna" -o \
    -name "*.fa" -o \
    -name "*.fasta" \
\) -exec mv {} . \;

# Clean up
rm -rf "$TMPDIR"
rm -f "$ZIPFILE"

echo "Done!"