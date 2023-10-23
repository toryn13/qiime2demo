#!/bin/bash

export PATH=opt/miniconda3/envs/qiime2-2023.9/bin:$PATH

qiime feature-classifier classify-sklearn \
  --i-reads rep-seqs-dada2.qza \
  --i-classifier gg-13-8-99-nb-classifier.qza \
  --o-classification taxonomy.qza

qiime metadata tabulate \
  --m-input-file taxonomy.qza \
  --o-visualization taxonomy.qzv

qiime phylogeny align-to-tree-mafft-fasttree \
  --i-sequences rep-seqs-dada2.qza  \
  --o-alignment aligned-rep-seqs.qza \
  --o-masked-alignment masked-aligned-rep-seqs.qza \
  --o-tree unrooted-tree.qza \
  --o-rooted-tree rooted-tree.qza

qiime empress tree-plot \
    --i-tree rooted-tree.qza \
    --m-feature-metadata-file taxonomy.qza \
    --o-visualization tree-viz.qzv
