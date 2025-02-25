#!/bin/bash
#eudicotyledons Taxonomy ID: 71240 or Saxifragales Taxonomy ID: 41946

conda activate oatk

#create oatk database
/data/fdalgrande_data/tools/OatkDB/oatkdb -t 8 -o eudicotiledons_mito 71240 mitochondrion &

#run oatk
oatk -k 1001 -c 70 -t 10 -m eudicot.fam -o Stomb_mito_oatk /data/fdalgrande_data/Stombeanensis/S_tomb.hifi_reads.fastq.gz &
