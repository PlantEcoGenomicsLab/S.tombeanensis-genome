 #!/bin/bash --login
#SBATCH --job-name=busco_AS
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out
#SBATCH --partition=cpu
#SBATCH --mem=300G
#SBATCH --cpus-per-task=20

#run diamond on the primary curated assembly
/data/fdalgrande_data/tools/diamond blastx \
        --query  ../assemblies/S_tomb_removed_organelles.curated_unwrapped.fa \
        --db /data/fdalgrande_data/tools/swissprot.taxids.dmnd \
        --outfmt 6 qseqid staxids bitscore qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue \
        --sensitive \
        --max-target-seqs 5 \
        --evalue 1e-25 \
        --threads 16 \
        > S_tomb.primary.filtered.curated.diamond.out &
