singularity exec docker://ghcr.io/marcelauliano/mitohifi:master mitohifi.py \
        -r /data/fdalgrande_data/Stombeanensis/S_tomb.hifi_reads.fastq.gz \
        -f /data/fdalgrande_data/Stombeanensis/organelles/mitochondrion/Ribes_nigrum_mito.fna \
        -g /data/fdalgrande_data/Stombeanensis/organelles/mitochondrion/Ribes_nigrum_mito.gb \
        -t 30 \
        -a plant &
