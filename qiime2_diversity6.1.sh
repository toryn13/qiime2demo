#!/bin/bash

export PATH=opt/miniconda3/envs/qiime2-2023.9/bin:$PATH

#Select a samppling depth

#Core metrics
qiime diversity core-metrics-phylogenetic \
  --i-phylogeny rooted-tree.qza \
  --i-table table-dada2.qza \
  --p-sampling-depth 9777  \
  --m-metadata-file metadata.txt \
  --output-dir core-metrics-results

#Add any alpha diversity 
qiime diversity alpha-group-significance \
  --i-alpha-diversity core-metrics-results/faith_pd_vector.qza \
  --m-metadata-file metadata.txt \
  --o-visualization core-metrics-results/faith-pd-group-significance.qzv

qiime diversity alpha-group-significance \
  --i-alpha-diversity core-metrics-results/evenness_vector.qza \
  --m-metadata-file metadata.txt \
  --o-visualization core-metrics-results/evenness-group-significance.qzv

#Add any beta diversity, select a column in the metadata
  qiime diversity beta-group-significance \
  --i-distance-matrix core-metrics-results/weighted_unifrac_distance_matrix.qza \
  --m-metadata-file metadata.txt \
  --m-metadata-column group  \
  --o-visualization core-metrics-results/weighted-unifrac-significance.qzv \
  --p-pairwise

#Add the rarefaction depth to min frequency 
qiime feature-table filter-samples \
  --i-table table-dada2.qza \
  --p-min-frequency 9777  \
  --o-filtered-table table_taxa.qza

qiime taxa barplot \
  --i-table table_taxa.qza \
  --i-taxonomy taxonomy.qza \
  --m-metadata-file metadata.txt \
  --o-visualization taxa_barplot.qzv
