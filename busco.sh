#!/bin/bash --login
#SBATCH --job-name=busco_ST
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out
#SBATCH --partition=cpu
#SBATCH --mem=300G
#SBATCH --cpus-per-task=20

conda activate test

#evaluate the completeness of the genome assembly using BUSCO with the Viridiplantae database
#hap1
busco \
 -i /data/fdalgrande_data/Stombeanensis/S_tomb.asm.bp.hap1.p_ctg.fa \
 -l viridiplantae_odb10 \
 -m genome \
 -o S_tomb.asm.bp.hap1_completeness &

#hap2
busco \
 -i /data/fdalgrande_data/Stombeanensis/S_tomb.asm.bp.hap2.p_ctg.fa \
 -l viridiplantae_odb10 \
 -m genome \
 -o S_tomb.asm.bp.hap2_completeness & 

#primary
busco \
 -i /data/fdalgrande_data/Stombeanensis/S_tomb.asm.bp.p_ctg.fa \
 -l viridiplantae_odb10 \
 -m genome \
 -o S_tomb.asm.bp.primary_completeness &
