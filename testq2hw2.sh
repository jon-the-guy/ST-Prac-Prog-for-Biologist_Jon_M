#!/bin/bash

# genes_per_chromosome.sh
# Script to count genes per chromosome from a GFF file

# A. Store the input file name in a variable
if [ -z "$1" ]; then
    INPUT_FILE="/home/shared/FA25_coding/Exam_1/SLF_genomic.gff"
    echo "No input file provided, using default: $INPUT_FILE" >&2
else
    INPUT_FILE="$1"
fi

# Check if input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' not found" >&2
    exit 1
fi

echo "Processing GFF file: $INPUT_FILE" >&2

# Diagnostic: Let's see what feature types exist and might be considered "genes"
echo "=== ANALYZING FEATURE TYPES ===" >&2
echo "Top 10 feature types and their counts:" >&2
grep -v '^#' "$INPUT_FILE" | awk '{print $3}' | sort | uniq -c | sort -rn | head -10 >&2

# Let's try counting multiple possible "gene" definitions
echo -e "\n=== COMPARING DIFFERENT COUNTING METHODS ===" >&2

# Method 1: Exact "gene" match (current method)
echo "Method 1 - Exact 'gene' match:" >&2
grep -v '^#' "$INPUT_FILE" | awk '$3 == "gene"' | wc -l | awk '{print "  Total genes: " $1}' >&2

# Method 2: Case-insensitive gene match
echo "Method 2 - Case-insensitive 'gene' match:" >&2
grep -v '^#' "$INPUT_FILE" | awk 'tolower($3) ~ /gene/' | wc -l | awk '{print "  Total gene-like: " $1}' >&2

# Method 3: Count all features (to see total volume)
echo "Method 3 - All features:" >&2
grep -v '^#' "$INPUT_FILE" | wc -l | awk '{print "  Total features: " $1}' >&2

# Method 4: Common genomic features that might be counted
echo "Method 4 - Common genomic features:" >&2
for feature in gene mRNA exon CDS transcript; do
    count=$(grep -v '^#' "$INPUT_FILE" | awk -v f="$feature" '$3 == f' | wc -l)
    echo "  $feature: $count" >&2
done

# FINAL OUTPUT - Using the original "gene" definition but let's see what we get
echo -e "\n=== FINAL OUTPUT ==="
echo -e "Chromosome\tGeneCount"

# Count using the standard definition but output in expected chromosome order
for chrom in NC_012835.1 NC_134455.1 NC_134456.1 NC_134457.1 NC_134458.1 NC_134459.1 NC_134460.1 NC_134461.1 NC_134462.1 NC_134463.1 NC_134464.1 NC_134465.1 NC_134466.1 NC_134467.1; do
    count=$(grep -v '^#' "$INPUT_FILE" | awk -v c="$chrom" '$1 == c && $3 == "gene"' | wc -l)
    echo -e "$chrom\t$count"
done

echo "Analysis complete." >&2
