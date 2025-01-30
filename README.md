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

## Blobtools 
To visualised blobtools interactive pages type on your terminal:
`blobtools view --remote blobtools_folder`
It will appear something like: 
`Initializing viewer
View dataset at http://localhost:8001/view/blobtools_Stomb_hap1/dataset/blobtools_Stomb_hap1/blob
For remote access use:
    ssh -L 8001:127.0.0.1:8001 -L 8000:127.0.0.1:8000 username@remote_host`
