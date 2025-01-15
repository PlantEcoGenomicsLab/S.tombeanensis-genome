#installing pbtk and FastQC is not necessary if you're using Orto server
conda install -c bioconda pbtk
conda install bioconda::fastqc

#transform bam file in fastq, because FastQC only accepts this format
bam2fastq /data/fdalgrande_data/Stombeanensis/S_tomb.hifi_reads.bam -o /data/fdalgrande_data/Stombeanensis/S_tomb.hifi_reads &

#run FastQC
mkdir fastqc_rawreads
fastqc S_tomb.hifi_reads.fastq -o fastqc_rawreads &
