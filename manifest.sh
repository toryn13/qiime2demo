#! /bin/bash

# Create a manifest file for paired-end FASTQ files

# Define the output manifest file
output_manifest="manifest.tsv"

# Define the working directory as the current directory
working_dir=$(pwd)

# Start writing the header to the manifest file
echo -e "SampleID\tforward-absolute-filepath\treverse-absolute-filepath" > "$output_manifest"

# Loop through all forward FASTQ files and construct the manifest entries
for forward_file in "$working_dir"/*.raw_1.fq.gz; do
    # Check if the corresponding reverse file exists
    reverse_file="${forward_file/raw_1/raw_2}"
    if [ -e "$reverse_file" ]; then
        # Extract the sample name from the file name
        sample_name=$(basename "$forward_file" .raw_1.fq.gz)

        # Append the entry to the manifest file with full absolute file paths
        forward_absolute_path="$working_dir/$sample_name.raw_1.fq.gz"
        reverse_absolute_path="$working_dir/$sample_name.raw_2.fq.gz"
        echo -e "$sample_name\t$forward_absolute_path\t$reverse_absolute_path" >> "$output_manifest"
    fi
done

# Inform the user that the manifest file has been created
echo "Manifest file '$output_manifest' has been generated."


