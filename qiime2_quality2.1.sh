#!/bin/bash

export PATH=opt/miniconda3/envs/qiime2-2023.9/bin:$PATH

qiime tools import \
  --input-path manifest.tsv \
  --type 'SampleData[PairedEndSequencesWithQuality]' \
  --input-format PairedEndFastqManifestPhred33V2 \
  --output-path pe-demux.qza

qiime cutadapt trim-paired --i-demultiplexed-sequences pe-demux.qza \
  --p-front-r  ACTACHVGGGTATCTAATCC \
  --p-front-f GCCTACGGGNGGCWGCAG \
  --o-trimmed-sequences trim-demux.qza

qiime demux summarize \
    --i-data  pe-demux.qza \
    --o-visualization pe-demux.qzv

qiime demux summarize \
    --i-data trim-demux.qza \
    --o-visualization trim-demux.qzv

