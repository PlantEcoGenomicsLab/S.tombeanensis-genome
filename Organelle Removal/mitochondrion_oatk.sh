 #!/bin/bash

#create the database from eudicotiledons in NCBI, Taxonomy ID: 71240
data/fdalgrande_data/tools/OatkDB/oatkdb -t 8 --output eudicotyledons_mito 71240 mitochondrion &#conda activate oatk
#run oatk
oatk -k 1001 -c 70 -t 10 -m eudicotyledons_mito.fam -o Stomb_mito_oatk /data/fdalgrande_data/Stombeanensis/S_tomb.hifi_reads.fastq.gz &
