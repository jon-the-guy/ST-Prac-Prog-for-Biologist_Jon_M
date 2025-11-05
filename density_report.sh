#!/bin/bash


# Script to count genes per chromosome and classify density from a GFF file
# Homework 2 - Question 5
# Mod from genes_per_chromosome.sh to include density 

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

# Create output file with header
OUTPUT_FILE="density_report.txt"
echo -e "Chromosome\tGeneCount\tClass" > "$OUTPUT_FILE"

echo "Analyzing gene density and creating report..." >&2

# Process each chromosome
for chrom in "${CHROMOSOMES[@]}"; do
    # Count genes for this chromosome
    # Filter: skip header lines, match chromosome in field 1, extract field 3, count exact "gene" matches
    gene_count=$(grep -v '^#' "$INPUT_FILE" | grep "^$chrom" | cut -f3 | grep -c "^gene$")
    
    # A. Add if/then statement to classify density
    if [ "$gene_count" -gt 2000 ]; then
        density_class="High-density"
    else
        density_class="Low-density"
    fi
    
    # Append to output file (three-column table)
    echo -e "$chrom\t$gene_count\t$density_class" >> "$OUTPUT_FILE"
done

echo "Analysis complete. Density report saved to $OUTPUT_FILE" >&2

# Display the created report
echo -e "\nContents of $OUTPUT_FILE:" >&2
cat "$OUTPUT_FILE" >&2
