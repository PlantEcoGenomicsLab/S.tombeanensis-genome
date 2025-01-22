#!/bin/bash --login
#SBATCH --job-name=minimap2_AP
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out
#SBATCH --partition=cpu
#SBATCH --mem=300G
#SBATCH --cpus-per-task=20

conda activate test

#indexing the assebly
minimap2 -d S_tomb.asm.bp.hap1.p_ctg.fa.mmi /data/fdalgrande_data/Stombeanensis/S_tomb.asm.bp.hap1.p_ctg.fa

#aligning...assembled reads to raw reads (subreads.bam/fastq in case of pacbio)
minimap2 -ax map-pb /data/fdalgrande_data/Stombeanensis/S_tomb.asm.bp.hap1.p_ctg.fa \
 /data/fdalgrande_data/Stombeanensis/S_tomb.hifi_reads.fastq.gz > aln_S_tomb.asm.bp.hap1.sam  & # for PacBio subreads

#converting the output to bam and sort it
samtools view -S -b aln_S_tomb.asm.bp.hap1.sam > aln_S_tomb.asm.bp.hap1.bam &

samtools sort aln_S_tomb.asm.bp.hap1.bam -o aln_S_tomb.asm.bp.hap1.sorted.bam &
samtools index aln_S_tomb.asm.bp.hap1.sorted.bam &
