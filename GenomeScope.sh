 #!/bin/bash --login

FastK -v -t4 -k31 -M30 -T4 ../S_tomb.hifi_reads.fastq.gz -NS_tomb_1 &

Histex -G S_tomb_1 > S_tomb_k31.hist

#module load R
/home/dalgrande_lab_workspace/tools/genomescope2.0/genomescope.R -i S_tomb_k31.hist -o S_tomb_k31_GS_out -k 31

#run Smudgeplot to analyze heterozygous k-mers with a minimum k-mer length of 40
python3 /home/fdalgrande/bin/smudgeplot.py hetmers S_tomb_1 -L 40 \
 -t 4 --verbose -o S_tomb_k31_pairs &

smudgeplot.py all -o trial_run_Stombea S_tomb_k31_pairs_text.smu
