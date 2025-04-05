 #!/bin/bash
#RepeatModeler
#Generate a species specific repeat library using the BLAST database
conda activate RepeatMasker
BuildDatabase -name saxifraga_db /data/fdalgrande_data/Stombeanensis/assemblies/S_tomb_removed_organelles.curated.fasta
#Database is then used to build, refine, and classify consensus models of putative interspersed repeats with RECON and RepeatScoud
RepeatModeler -database saxifraga_db -threads 20 -LTRStruct >& run.out &

#RepeatMasker
#Perform soft masking of the assembly by masking repetitive regions with lower case letters
RepeatMasker -pa 30 -gff -xsmall -lib saxifraga_db-families.fa -dir /data/fdalgrande_data/Stombeanensis/annotation/RepeatMasker /data/fdalgrande_data/Stombeanensis/assemblies/S_tomb_removed_organelles.curated.fasta
