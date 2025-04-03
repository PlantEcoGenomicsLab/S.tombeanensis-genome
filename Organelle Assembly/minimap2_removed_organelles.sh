  #!/bin/bash --login
#SBATCH --job-name=minimap2_AP
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out
#SBATCH --partition=cpu
#SBATCH --mem=300G
#SBATCH --cpus-per-task=20

conda activate test

#run minimap2 on the primary assembly where the organelles have been removed
#indexing the assebly
minimap2 -d S_tomb_removed_organelles.mmi /data/fdalgrande_data/Stombeanensis/blast/S_tomb_removed_organelles_80.fa &

minimap2 -ax map-pb /data/fdalgrande_data/Stombeanensis/blast/S_tomb_removed_organelles_80.fa /data/fdalgrande_data/Stombeanensis/S_tomb.hifi_reads.fastq.gz > aln_S_tomb_removed_organelles.sam  & # for PacBio subreads

#converting the output to bam and sort it
samtools view -S -b aln_S_tomb_removed_organelles.sam > aln_S_tomb_removed_organelles.bam &
samtools view aln_S_tomb_removed_organelles.bam | head
samtools sort aln_S_tomb_removed_organelles.bam -o aln_S_tomb_removed_organelles.sorted.bam &
samtools index -c aln_S_tomb_removed_organelles.sorted.bam &
