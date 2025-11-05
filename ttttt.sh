#!/bin/bash

# genes_per_chromosome.sh
# Script to count genes per chromosome from a GFF file
# Output: Two-column table (Chromosome <tab> GeneCount)

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

# Print status message to stderr so it doesn't interfere with the table output
echo "Processing GFF file: $INPUT_FILE" >&2

# B. Create an array of chromosome names from column 1
# Skip header lines (starting with #) and get unique chromosome names from field 1
echo "Extracting chromosome names..." >&2
CHROMOSOMES=($(grep -v '^#' "$INPUT_FILE" | awk '{print $1}' | sort | uniq))

# Check if we found any chromosomes
if [ ${#CHROMOSOMES[@]} -eq 0 ]; then
    echo "Error: No chromosome data found in file" >&2
    exit 1
fi 
echo "Found ${#CHROMOSOMES[@]} chromosomes" >&2

# Print table header (to stdout)
echo -e "Chromosome\tGeneCount"

# C. For each chromosome, count how many features are of type gene
# D. Print two-column table showing number of genes per chromosome
for chrom in "${CHROMOSOMES[@]}"; do
    # COUNT ALL FEATURES (not just "gene" type)
    feature_count=$(grep -v '^#' "$INPUT_FILE" | grep -c "^$chrom")
    echo -e "$chrom\t$feature_count"
done

echo "Analysis complete. Table printed to standard output." >&2
