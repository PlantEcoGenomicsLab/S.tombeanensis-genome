#!/bin/bash

conda activate test

#cat all the closely related reference plastid genomes
cat Saxifraga*.fna > Chloroplast_5.fna

#run ptGAUL
ptGAUL.sh -r Chloroplast_5.fna -l S_tomb.hifi_reads.fastq.gz -o chloroplast_Stomb -t 30 &
