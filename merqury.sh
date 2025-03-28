  #!/bin/bash --login
#SBATCH --job-name=merqury_ST
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out
#SBATCH --partition=cpu
#SBATCH --mem=30G
#SBATCH --cpus-per-task=20

#sh $MERQURY/best_k.sh  [tolerable_collision_rate=0.001]
conda activate merqury
#this script uses Merqury to assess the quality of the curated primary genome assembly by comparing it to the k-mer content of raw HiFi reads. 
#count k-mers (k=31) from the raw HiFi reads
meryl k=31 count /data/fdalgrande_data/Stombeanensis/*.fastq.gz output $genome.meryl

merqury.sh .meryl /data/fdalgrande_data/Stombeanensis/assemblies/purge_haplotigs/S_tomb_removed_organelles.curated.fasta S_tomb_curated_merqury_results &
