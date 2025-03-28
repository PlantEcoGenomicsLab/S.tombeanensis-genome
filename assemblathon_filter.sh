##assemblathon for assessing quality of the assembly primary.filtered
perlbrew use 5.10.1
perl5.10.1 -I /data/fdalgrande_data/tools/ /data/fdalgrande_data/tools/assemblathon_stats.pl ../S_tomb.asm.bp.p_ctg.filtered.fa > S_tomb.asm.bp.p_ctg.filtered.assemlathon_stats.txt
exit

##assemblathon for assessing quality of the assembly hap1.filtered
perlbrew use 5.10.1
perl5.10.1 -I /data/fdalgrande_data/tools/ /data/fdalgrande_data/tools/assemblathon_stats.pl ../S_tomb.asm.bp.hap1.p_ctg.filtered.fa > S_tomb.asm.bp.hap1.filtered.assemblathon_stats.txt
exit

##assemblathon for assessing quality of the assembly hap2.filtered
perlbrew use 5.10.1
perl5.10.1 -I /data/fdalgrande_data/tools/ /data/fdalgrande_data/tools/assemblathon_stats.pl ../S_tomb.asm.bp.hap2.p_ctg.filtered.fa > S_tomb.asm.bp.hap2.filtered.assemblathon_stats.txt
exit
