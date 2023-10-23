#!/bin/bash

export PATH=opt/miniconda3/envs/qiime2-2023.9/bin:$PATH

#Select a truncation length

qiime dada2 denoise-paired \
  --i-demultiplexed-seqs trim-demux.qza \
  --p-trunc-len-f 250 \
  --p-trunc-len-r 220 \
  --p-n-threads 0 \
  --o-representative-sequences rep-seqs-dada2.qza \
  --o-table table-dada2.qza \
  --o-denoising-stats stats-dada2.qza

qiime feature-table tabulate-seqs \
  --i-data rep-seqs-dada2.qza \
  --o-visualization rep-seqs-dada2.qzv

qiime metadata tabulate \
  --m-input-file stats-dada2.qza \
  --o-visualization stats-dada2.qzv

qiime feature-table summarize \
    --i-table table-dada2.qza \
    --m-sample-metadata-file metadata.txt \
    --o-visualization table-dada2.qzv
