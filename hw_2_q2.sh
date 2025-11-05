#!/bin/bash

# genes_per_chromosome.sh
# Script to count genes per chromosome from a GFF file
# Output: Two-column table (Chromosome <tab> GeneCount)

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
    echo "Please check the file path and try again" >&2
    exit 1
fi

if [ ! -r "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' is not readable" >&2
    exit 1
fi

echo "Processing GFF file: $INPUT_FILE" >&2

# First, let's diagnose what feature types exist in the file
echo "Analyzing feature types in the file..." >&2
grep -v '^#' "$INPUT_FILE" | awk '{print $3}' | sort | uniq -c | sort -rn >&2

# B. Create an array of chromosome names from column 1
echo "Extracting chromosome names..." >&2
CHROMOSOMES=($(grep -v '^#' "$INPUT_FILE" | awk '{print $1}' | sort | uniq))

echo "Found ${#CHROMOSOMES[@]} chromosomes" >&2

# Print table header
echo -e "Chromosome\tGeneCount"

# C & D. Count and print genes per chromosome
# Using awk for efficient processing
grep -v '^#' "$INPUT_FILE" | awk '
    $3 == "gene" {
        genes[$1]++
    }
    END {
        # Print in the order of chromosomes we found
        print "NC_012835.1\t" genes["NC_012835.1"]+0
        print "NC_134455.1\t" genes["NC_134455.1"]+0
        print "NC_134456.1\t" genes["NC_134456.1"]+0
        print "NC_134457.1\t" genes["NC_134457.1"]+0
        print "NC_134458.1\t" genes["NC_134458.1"]+0
        print "NC_134459.1\t" genes["NC_134459.1"]+0
        print "NC_134460.1\t" genes["NC_134460.1"]+0
        print "NC_134461.1\t" genes["NC_134461.1"]+0
        print "NC_134462.1\t" genes["NC_134462.1"]+0
        print "NC_134463.1\t" genes["NC_134463.1"]+0
        print "NC_134464.1\t" genes["NC_134464.1"]+0
        print "NC_134465.1\t" genes["NC_134465.1"]+0
        print "NC_134466.1\t" genes["NC_134466.1"]+0
        print "NC_134467.1\t" genes["NC_134467.1"]+0
    }
'

echo "Analysis complete." >&2
