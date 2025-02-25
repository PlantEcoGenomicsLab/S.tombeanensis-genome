#!/bin/bash

#Filter organellar contigs from the whole-genome assembly
#for blast there's no need to activate conda environment, it is installed in the bin

#create the database from the organellar assemblies
makeblastdb -in Stomb_organelles_mod.fasta -out Stomb_organelles_db -parse_seqids -dbtype nucl &

#run a strict alignment
blastn -query /data/fdalgrande_data/Stombeanensis/S_tomb.asm.bp.p_ctg.filtered.fa -db Stomb_organelles_db -out Blast_results.csv -evalue 1e-30 -qcov_hsp_perc 80 -outfmt 6 -num_threads 15 &

awk '{print $1}' Blast_results.csv | sort | uniq > found_sequences.txt &

conda activate test
seqkit grep -v -f found_sequences.txt /data/fdalgrande_data/Stombeanensis/S_tomb.asm.bp.p_ctg.filtered.fa > S_tomb_removed_organelles.fa &
