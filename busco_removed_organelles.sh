 #!/bin/bash --login
#SBATCH --job-name=busco_ST
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out
#SBATCH --partition=cpu
#SBATCH --mem=300G
#SBATCH --cpus-per-task=20

conda activate test
#evaluate the completeness of the primary assembly, after removing organelles, using BUSCO and different database

#viridiplantae_odb10 database
#primary
busco \
 -i /data/fdalgrande_data/Stombeanensis/blast/S_tomb_removed_organelles_80.fa \
 -l viridiplantae_odb10 \
 -m genome \
 -o S_tomb_removed_organelles_80_completeness &
 
#eudicots_odb10 database
#primary
busco \
 -i /data/fdalgrande_data/Stombeanensis/blast/S_tomb_removed_organelles_80.fa \
 -l eudicots_odb10 \
 -m genome \
 -o S_tomb_removed_organelles_80_eudi_completeness &
