 #!/bin/bash

#create the database from saxifragales in NCBI, Taxonomy ID: 41946
#create database
/data/fdalgrande_data/tools/OatkDB/oatkdb -t 8 --output saxifragales_chloro 41946 chloroplast &

#conda activate oatk
#run oatk
oatk -k 1001 -c 70 -t 10 -p saxifragales_chloro.fam  -o Stomb_plastid_oatk /data/fdalgrande_data/Stombeanensis/S_tomb.hifi_reads.fastq.gz &
