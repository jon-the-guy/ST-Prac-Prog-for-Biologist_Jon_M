#!/bin/bash

# Count total features and specific feature types from SLF.genome file

# A. Store the input file name in a variable
# Use provided argument or default to the specified file path
if [ -z "$1" ]; then
    INPUT_FILE="/home/shared/FA25_coding/Exam_1/SLF_genomic.gff"
    echo "No input file provided, using default: $INPUT_FILE" >&2
else
    INPUT_FILE="$1"
fi

# Check if input file exists and is readable
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' not found" >&2
    exit 1
fi

if [ ! -r "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' is not readable" >&2
    exit 1
fi

echo "Processing GFF file: $INPUT_FILE" >&2

# B. Count how many total features exist (excluding header lines)
total_features=$(grep -v '^#' "$INPUT_FILE" | wc -l)

# C. Count how many features are of gene, mRNA, and exon
gene_count=$(grep -v '^#' "$INPUT_FILE" | cut -f3 | grep -c '^gene$')
mrna_count=$(grep -v '^#' "$INPUT_FILE" | cut -f3 | grep -c '^mRNA$')
exon_count=$(grep -v '^#' "$INPUT_FILE" | cut -f3 | grep -c '^exon$')

# D. Print report to standard out
echo "Total number of features: $total_features"
echo -e "gene:\t$gene_count"
echo -e "mRNA:\t$mrna_count"
echo -e "exon:\t$exon_count"


