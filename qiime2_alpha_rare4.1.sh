#!/bin/bash

export PATH=opt/miniconda3/envs/qiime2-2023.9/bin:$PATH

#Pick a max-depth

qiime diversity alpha-rarefaction \
  --i-table table-dada2.qza \
  --i-phylogeny rooted-tree.qza \
  --p-max-depth 9777 \
  --m-metadata-file metadata.txt \
  --o-visualization alpha-rarefaction.qzv
