 #!/bin/bash --login
source ~/miniconda3/etc/profile.d/conda.sh
conda activate purge_haplotigs

#create the histogram with aln_S_tomb_removed_organelles.sorted.bam file
purge_haplotigs readhist \
       -b /data/fdalgrande_data/Stombeanensis/minimap2/removed_organelles/aln_S_tomb_removed_organelles.sorted.bam \
       -g ../S_tomb_removed_organelles_80.fa &
#use the histogram to detect the value of -l -m -h
purge_haplotigs  contigcov  -i aln_S_tomb_removed_organelles.sorted.bam.200.gencov -l 5 -m 25 -h 80 -c coverage_stats.csv &
#purge the assemplies using the statistics file
purge_haplotigs purge  -g S_tomb_removed_organelles_80.fa  -c coverage_stats.csv -o S_tomb_removed_organelles.curated &
#run again the last command ad add the lasts flag to obtain the dots plot
purge_haplotigs purge  -g S_tomb_removed_organelles_80.fa  -c coverage_stats.csv -o S_tomb_removed_organelles.curated  -d -b /data/fdalgrande_data/Stombeanensis/minimap2/removed_organelles/aln_S_tomb_removed_organelles.sorted.bam &
