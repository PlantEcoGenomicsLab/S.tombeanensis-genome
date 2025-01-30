#!/bin/bash --login

#haplotipe1
blobtools filter \
     --param bestsumorder_phylum--Inv=Streptophyta \
     --out Stomb_hap1.filtered.blobtools \
     --fasta /data/fdalgrande_data/Stombeanensis/S_tomb.asm.bp.hap1.p_ctg.fa \
     --summary summary_Stomb_hap1.txt \
     --table ~ blobtools_Stomb_hap1/ &

#haplotipe2
blobtools filter \
     --param bestsumorder_phylum--Inv=Streptophyta \
     --out Stomb_hap2.filtered.blobtools \
     --fasta /data/fdalgrande_data/Stombeanensis/S_tomb.asm.bp.hap2.p_ctg.fa \
     --summary summary_Stomb_hap2.txt \
     --table ~ blobtools_Stomb_hap2/ &

#primary
blobtools filter \
     --param bestsumorder_phylum--Inv=Streptophyta \
     --out Stomb_hap1.filtered.blobtools \
     --fasta /data/fdalgrande_data/Stombeanensis/S_tomb.asm.bp.hap1.p_ctg.fa \
     --summary summary_Stomb_hap1.txt \
     --table ~ blobtools_Stomb_hap1/ &
