 #!/bin/bash --login
#SBATCH --job-name=busco_ST
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out
#SBATCH --partition=cpu
#SBATCH --mem=300G
#SBATCH --cpus-per-task=20

#conda activate test
#evaluate the completeness of primary assembly cured with purge haplotigs using BUSCO

#eudicots_odb10 database
busco \
 -i S_tomb_removed_organelles.curated.fasta \
 -l eudicots_odb10 \
 -m genome \
 -o S_tomb_removed_organelles.curated.eudi_completeness &
