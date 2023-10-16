#! /bin/bash

# Create a manifest file for paired-end FASTQ files

# Define the output manifest file
output_manifest="manifest.tsv"

# Start writing the header to the manifest file
echo -e "SampleID\tforward-absolute-filepath\treverse-absolute-filepath" > "$output_manifest"


# Loop through all FASTQ.gz files and construct the manifest entries
for f in *.raw_1.fq.gz; do
    # Extract the sample name from the file name
    sample_name=$(echo "$f" | cut -d '.' -f 1)

    # Construct the full file paths
    forward_seq="${sample_name}.raw_1.fq.gz"
    reverse_seq="${sample_name}.raw_2.fq.gz"

    # Append the entry to the manifest file
    echo -e "$sample_name\t$forward-absolute-filepath\t$forward-absolute-filepath" >> "$output_manifest"
done

# Inform the user that the manifest file has been created
echo "Manifest file '$output_manifest' has been generated."
