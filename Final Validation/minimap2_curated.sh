  #!/bin/bash --login
#SBATCH --job-name=minimap2_AP
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out
#SBATCH --partition=cpu
#SBATCH --mem=300G
#SBATCH --cpus-per-task=20

conda activate test
#run minimap2 on the primary assembly curated with purge haplotigs
#indexing the assebly
minimap2 -d S_tomb_curated.mmi /data/fdalgrande_data/Stombeanensis/assemblies/purge_haplotigs/S_tomb_removed_organelles.curated.fasta &

minimap2 -ax map-pb /data/fdalgrande_data/Stombeanensis/assemblies/purge_haplotigs/S_tomb_removed_organelles.curated.fasta /data/fdalgrande_data/Stombeanensis/S_tomb.hifi_reads.fastq.gz > aln_S_tomb_curated.sam  & # for PacBio subreads

#converting the output to bam and sort it
samtools view -S -b aln_S_tomb_curated.sam > aln_S_tomb_curated.bam &
samtools sort aln_S_tomb_curated.bam -o aln_S_tomb_curated.sorted.bam &
samtools index -c aln_S_tomb_curated.sorted.bam &
