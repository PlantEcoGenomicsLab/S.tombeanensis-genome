##assemblathon for assessing quality of the assembly primary
perlbrew use 5.10.1
perl5.10.1 -I /data/fdalgrande_data/tools/ /data/fdalgrande_data/tools/assemblathon_stats.pl ../S_tomb.asm.bp.p_ctg.fa > S_tomb.asm.bp.p_ctg.assemlathon_stats.txt
exit

##assemblathon for assessing quality of the assembly hap1
perlbrew use 5.10.1
perl5.10.1 -I /data/fdalgrande_data/tools/ /data/fdalgrande_data/tools/assemblathon_stats.pl ../S_tomb.asm.bp.hap1.p_ctg.fa > S_tomb.asm.bp.hap1.assemblathon_stats.txt
exit

##assemblathon for assessing quality of the assembly hap2
perlbrew use 5.10.1
perl5.10.1 -I /data/fdalgrande_data/tools/ /data/fdalgrande_data/tools/assemblathon_stats.pl ../S_tomb.asm.bp.hap2.p_ctg.fa > S_tomb.asm.bp.hap2.assemblathon_stats.txt
exit
