#!/bin/bash

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

# B. Create a file listing all chromosome IDs
# Extract unique chromosome names from field 1, excluding header lines
CHROMOSOME_LIST="chromosome_list.txt"
echo "Creating chromosome list file: $CHROMOSOME_LIST" >&2
grep -v '^#' "$INPUT_FILE" | awk '{print $1}' | sort | uniq > "$CHROMOSOME_LIST"

# Check if chromosome list was created successfully
if [ ! -s "$CHROMOSOME_LIST" ]; then
    echo "Error: No chromosomes found in file" >&2
    exit 1
fi

echo "Found $(wc -l < "$CHROMOSOME_LIST") chromosomes" >&2

# C. Use a while loop to read each chromosome ID
# D. For each chromosome, save all lines for that chromosome into a new file
# E. Print status message to standard out after writing each file
echo "Splitting GFF file by chromosome..." >&2

while IFS= read -r chromosome; do
    # Create output filename using chromosome name
    output_file="${chromosome}.gff"
    
    # Extract all lines for this chromosome (including headers that might reference it)
    # First include relevant headers, then all data lines for the chromosome
    grep "^#.*$chromosome" "$INPUT_FILE" > "$output_file" 2>/dev/null || true
    grep -v '^#' "$INPUT_FILE" | grep "^$chromosome" >> "$output_file"
    
    # Print status message to standard out
    echo "Wrote $output_file"
    
done < "$CHROMOSOME_LIST"

# Clean up temporary file
rm "$CHROMOSOME_LIST"

echo "Splitting complete. Created $(ls *.gff | wc -l) chromosome GFF files." >&2
