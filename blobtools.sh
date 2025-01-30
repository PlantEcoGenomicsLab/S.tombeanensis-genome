#!/bin/bash --login

conda activate test

#haplotype1
blobtools create --fasta /data/fdalgrande_data/Stombeanensis/S_tomb.asm.bp.hap1.p_ctg.fa \
 --cov /data/fdalgrande_data/Stombeanensis/minimap2/aln_S_tomb.asm.bp.hap1.sorted.bam \
 --busco busco_full_table_Stomb_hap1.tsv \
 --hits /data/fdalgrande_data/Stombeanensis/diamond/S_tomb.asm.bp.hap1.diamond.out \
 --taxdump /data/fdalgrande_data/tools/taxdump \
blobtools_Stomb_hap1 &

#haplotype2
blobtools create --fasta /data/fdalgrande_data/Stombeanensis/S_tomb.asm.bp.hap2.p_ctg.fa \
 --cov /data/fdalgrande_data/Stombeanensis/minimap2/aln_S_tomb.asm.bp.hap2.sorted.bam \
 --busco busco_full_table_Stomb_hap2.tsv \
 --hits /data/fdalgrande_data/Stombeanensis/diamond/S_tomb.asm.bp.hap2.diamond.out \
 --taxdump /data/fdalgrande_data/tools/taxdump \
blobtools_Stomb_hap2 &

#primary
blobtools create --fasta /data/fdalgrande_data/Stombeanensis/S_tomb.asm.bp.p_ctg.fa \
--cov /data/fdalgrande_data/Stombeanensis/minimap2/aln_S_tomb.asm.bp.primary.sorted.bam \
