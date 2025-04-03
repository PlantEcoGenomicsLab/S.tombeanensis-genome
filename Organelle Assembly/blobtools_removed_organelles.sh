#!/bin/bash --login

conda activate btk

#create a BlobTools database using the primary assembly, after removing organelles
#we integrate sequence data, coverage information and BUSCO completeness results

blobtools create \
    --fasta /data/fdalgrande_data/Stombeanensis/blast/S_tomb_removed_organelles_80.fa \
    --cov /data/fdalgrande_data/Stombeanensis/minimap2/removed_organelles/aln_S_tomb_removed_organelles.sorted.bam \
    --busco /data/fdalgrande_data/Stombeanensis/busco/removed_organelles_busco/S_tomb_removed_organelles_80_eudi_completeness/run_eudicots_odb10/full_table.tsv \
blobtools_Stomb_removed_organelles_primary &
