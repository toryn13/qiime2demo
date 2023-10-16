#! /bin/bash

# Create a manifest file for paired-end FASTQ files

# Define the output manifest file
output_manifest="manifest.tsv"

# Start writing the header to the manifest file
echo -e "SampleID\tforward-absolute-filepath\treverse-absolute-filepath" > "$output_manifest"

# Loop through all forward FASTQ files and construct the manifest entries
for forward_file in *.raw_1.fq.gz; do
    # Check if the corresponding reverse file exists
    reverse_file="${forward_file/raw_1/raw_2}"
    if [ -e "$reverse_file" ]; then
        # Extract the sample name from the file name
        sample_name=$(basename "$forward_file" .raw_1.fq.gz)

        # Append the entry to the manifest file
        echo -e "$sample_name\t$forward_file\t$reverse_file" >> "$output_manifest"
    fi
done

# Inform the user that the manifest file has been created
echo "Manifest file '$output_manifest' has been generated."

