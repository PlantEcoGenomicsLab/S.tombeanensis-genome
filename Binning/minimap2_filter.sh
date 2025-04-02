#PRIMARY_FILTERED
  #!/bin/bash --login
#SBATCH --job-name=minimap2_AP
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out
#SBATCH --partition=cpu
#SBATCH --mem=300G
#SBATCH --cpus-per-task=20

conda activate test

#run minimap2 to align the HiFi reads against the filtered primary assembly
minimap2 -t 8 -ax map-pb /data/fdalgrande_data/Stombeanensis/S_tomb.asm.bp.p_ctg.filtered.fa /data/fdalgrande_data/Stombeanensis/S_tomb.hifi_reads.fastq.gz \
| samtools sort -o aln_S_tomb.asm.bp.primary.filtered.bam | samtools index &
