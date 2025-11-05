#!/bin/bash


# summarize_split_gffs_array.sh
# Script to summarize feature counts from individual chromosome GFF files


# This script creates a summary table of feature counts per chromosome

# A. Define an array of feature types to summarize
FEATURE_TYPES=("gene" "mRNA" "exon")

# B. Create output file with header line
OUTPUT_FILE="chromosome_summary.txt"
echo -e "Chromosome\tGene\tmRNA\tExon" > "$OUTPUT_FILE"

echo "Starting summary of chromosome GFF files..." >&2
echo "Feature types to analyze: ${FEATURE_TYPES[*]}" >&2

# C. Loop through every .gff file created in Task 3
for gff_file in *.gff; do
    # Skip if no GFF files found
    if [ ! -f "$gff_file" ]; then
        echo "Warning: No GFF files found in current directory" >&2
        continue
    fi
    
    echo "Processing $gff_file..." >&2
    
    # Initialize counts array for this file
    declare -a counts=()
    
    # C.1 Loop through each feature type in the array and count occurrences
    for feature_type in "${FEATURE_TYPES[@]}"; do
        # Count how many times each feature type appears in the file
        # Using cut to get field 3 (feature type) and count exact matches
        feature_count=$(cut -f3 "$gff_file" | grep -c "^${feature_type}$")
        counts+=("$feature_count")
    done
    
    # C.2 Write the line to the output file
    # Format: filename, gene_count, mrna_count, exon_count (tab-separated)
    echo -e "$gff_file\t${counts[0]}\t${counts[1]}\t${counts[2]}" >> "$OUTPUT_FILE"
    
    # Clean up the array for next iteration
    unset counts
done

# D. Write completed status to standard out
echo "Summary complete. Results written to $OUTPUT_FILE" >&2

# Display the created summary file
echo -e "\nContents of $OUTPUT_FILE:" >&2
cat "$OUTPUT_FILE" >&2
