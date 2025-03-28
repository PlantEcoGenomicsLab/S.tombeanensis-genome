#!/bin/bash --login

conda activate btk
#script to generate a BlobTools dataset using the primary assembly cured by purge haplotigs to reduce over-assembly
blobtools create \
    --fasta /data/fdalgrande_data/Stombeanensis/assemblies/purge_haplotigs/S_tomb_removed_organelles.curated.fasta \
    --cov /data/fdalgrande_data/Stombeanensis/minimap2/purgehap_output/aln_S_tomb_curated.sorted.bam \
    --busco /data/fdalgrande_data/Stombeanensis/busco/purgehap2_stomb/S_tomb_removed_organelles.curated.eudi_completeness/run_eudicots_odb10/full_table.tsv \
	  --hits /data/fdalgrande_data/Stombeanensis/diamond/S_tomb.primary.filtered.curated.diamond.out \
    --taxdump /data/fdalgrande_data/tools/taxdump \
blobtools_Stomb_primary_curated &
