import os
import shutil
import zipfile
import tempfile

def unzip_qza_files(qza_file_paths):
    for qza_file_path in qza_file_paths:
        try:
            # Create a temporary directory
            temp_dir = tempfile.mkdtemp()

            # Unzip the .qza file directly into the temporary directory
            with zipfile.ZipFile(qza_file_path, 'r') as zip_ref:
                zip_ref.extractall(temp_dir)

            # Iterate through the extracted directories
            for root, dirs, files in os.walk(temp_dir):
                # Find the first unnamed text file (CSV, TSV, or TXT)
                target_file = None
                for file_name in files:
                     if file_name.lower().endswith(('.csv', '.tsv', '.txt', 'biom', 'nwk')) and not file_name.startswith('.'):
                        target_file = os.path.join(root, file_name)
                        break

                # Check if a suitable file was found
                if target_file:
                    # Perform the copy operation (copy to the current working directory)
                    shutil.copy(target_file, os.getcwd())
                    break  # Stop searching once a file is found

            # Clean up the temporary directory and its contents
            shutil.rmtree(temp_dir)

            file_name = os.path.basename(qza_file_path)
            print(f"Unzipped and copied file: {file_name}")
        except Exception as e:
            print(f"An error occurred while processing {qza_file_path}: {e}")

# Example usage:
# qza_file_paths = ['file1.qza', 'file2.qza']
# unzip_qza_files(qza_file_paths)

