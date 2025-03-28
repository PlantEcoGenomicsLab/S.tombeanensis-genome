#!/bin/bash --login
#SBATCH --job-name=busco_ST
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out
#SBATCH --partition=cpu
#SBATCH --mem=300G
#SBATCH --cpus-per-task=20

conda activate test

#evaluate the completeness of the genome assembly after removing all non-Streptophyta using BUSCO

#viridiplantae_odb10 database
#hap1
busco \
 -i /data/fdalgrande_data/Stombeanensis/S_tomb.asm.bp.hap1.p_ctg.filtered.fa \
 -l viridiplantae_odb10 \
 -m genome \
 -o S_tomb.asm.bp.hap1.filtered_completeness &

#viridiplantae_odb10 database
#hap2
busco \
 -i /data/fdalgrande_data/Stombeanensis/S_tomb.asm.bp.hap2.p_ctg.filtered.fa \
 -l viridiplantae_odb10 \
 -m genome \
 -o S_tomb.asm.bp.hap2.filtered_completeness &
 
#viridiplantae_odb10 database
#primary
busco \
 -i /data/fdalgrande_data/Stombeanensis/S_tomb.asm.bp.p_ctg.filtered.fa \
 -l viridiplantae_odb10 \
 -m genome \
 -o S_tomb.asm.bp.filtered_completeness &

#eudicots_odb10 database
#primary
 busco \
 -i /data/fdalgrande_data/Stombeanensis/S_tomb.asm.bp.p_ctg.filtered.fa \
 -l eudicots_odb10 \
 -m genome \
 -o S_tomb.asm.bp.filtered_eudi_completeness &
