#!/bin/bash

REF_LIST=$1
OUT="NameConversion.tsv"

if [[ -z "$REF_LIST" ]]; then
    echo "Usage: $0 <References.list>"
    exit 1
fi

if [[ ! -f "$REF_LIST" ]]; then
    echo "Error: '$REF_LIST' not found."
    exit 1
fi

> "$OUT"

while read -r fasta; do

    # Skip blank lines
    [[ -z "$fasta" ]] && continue

    # Remove path and extension
    genome=$(basename "$fasta")

    # If you don't want to name it
    default=${genome%.*}

    # Interactive prompt for naming genomes
    read -p "Display name for ${genome} [${default}]: " name </dev/tty
    name="${name:-$default}"

    # Print line to name conversion file
    printf "%s\t%s\n" "$genome" "$name" >> "$OUT"

done < "$REF_LIST"

echo
echo "Thanks for playing!"
echo "${OUT}"
echo 
cat ${OUT}
echo 
echo 