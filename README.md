# S.tombeanensis-genome
Saxifraga tombeanensis genome assembly pipeline. 
Please note that all the annotated pipelines are suitable for fdalgrande@bio-orto, so if you're not using the server of the Botanical Garden of Padova you may have to change something.


## Quality Control
For quality control of PacBio HiFi reads we used `FastQC.sh`. 

## Raw Assembly
Initial raw assembly was done with `hifiasm1.sh`.

## Binning
Binning is performed with Blobtoolkit, which uses:
 - Raw assembly file (required)
 - Coverage file (optional)
 - Hits file (optional)
 - BUSCO completeness (optional)
### Coverage file
The coverage file (BAM format) was created using `minimap2.sh`

### Hits file
Hits file can be created with blastn or diamond blastx, we used `diamond.sh` 

### BUSCO completeness
We calculated commpleteness for the assembly using `busco.sh`
