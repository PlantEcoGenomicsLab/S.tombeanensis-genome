!/bin/bash --login
#SBATCH --job-name=diamond_ST
#SBATCH --error %x-%j.err
#SBATCH --output %x-%j.out
#SBATCH --partition=cpu
#SBATCH --mem=300G
#SBATCH --cpus-per-task=20

#run diamond on the haplotype1 assembly
/data/fdalgrande_data/tools/diamond blastx \
        --query  ../S_tomb.asm.bp.hap1.p_ctg.fa \
        --db /data/fdalgrande_data/tools/swissprot.taxids.dmnd \
        --outfmt 6 qseqid staxids bitscore qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue \
        --sensitive \
        --max-target-seqs 5 \
        --evalue 1e-25 \
        --threads 16 \
        > S_tomb.asm.bp.hap1.diamond.out &
        
#run diamond on the haplotype2 assembly
/data/fdalgrande_data/tools/diamond blastx \
        --query  ../S_tomb.asm.bp.hap2.p_ctg.fa \
        --db /data/fdalgrande_data/tools/swissprot.taxids.dmnd \
        --outfmt 6 qseqid staxids bitscore qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue \
        --sensitive \
        --max-target-seqs 5 \
        --evalue 1e-25 \
        --threads 16 \
        > S_tomb.asm.bp.hap2.diamond.out &
