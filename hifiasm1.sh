#!/bin/bash --login

#HifiAsm is used for genome assembly with high-precision sequencing data (HiFi) produced by PacBio
hifiasm -o /data/fdalgrande_data/Stombeanensis/S_tomb.asm -t 32 /data/fdalgrande_data/Stombeanensis/S_tomb.hifi_reads.fastq.gz 2> /data/fdalgrande_data/Stombeanensis/S_tomb.log &
#For genomes much larger than human (3.1 Gb), applying -f38 or even -f39 is preferred to save memory on k-mer counting

#The FASTA files can be produced from GFA as follows:
awk '/^S/{print ">"$2;print $3}' S_tomb.asm.bp.hap1.p_ctg.gfa > S_tomb.asm.bp.hap1.p_ctg.fa &   #haplotype1
awk '/^S/{print ">"$2;print $3}' S_tomb.asm.bp.hap2.p_ctg.gfa > S_tomb.asm.bp.hap2.p_ctg.fa &  #haplotype2
awk '/^S/{print ">"$2;print $3}' S_tomb.asm.bp.p_ctg.gfa > S_tomb.asm.bp.p_ctg.fa &  #primary assembly

#quality control of the assembly can be done with asseblathon (note it reuires perl 5.10.1)
perlbrew use 5.10.1
perl5.10.1 -I /data/fdalgrande_data/tools/ /data/fdalgrande_data/tools/assemblathon_stats.pl ../S_tomb.asm.bp.p_ctg.fa > S_tomb.asm.bp.p_ctg.assemlathon_stats.txt
exit
