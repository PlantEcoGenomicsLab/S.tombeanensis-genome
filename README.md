# S.tombeanensis-genome
Saxifraga tombeanensis genome assembly pipeline. 
Please note that all the annotated pipelines are suitable for fdalgrande@bio-orto, so if you're not using the server of the Botanical Garden of Padova you may have to change something.


## Quality Control
For quality control of PacBio HiFi reads we used `FastQC.sh`.
Additionally, we performed k-mer distribution analysis using `GenomeScope.sh` to estimate genome size and heterozygosity.

## Raw Assembly
Initial raw assembly was done with `hifiasm1.sh`.
We also used `busco.sh` to assess assembly completeness and `assemblathon.sh` to calculate a variety of assembly quality metrics.
From this point onwards, all subsequent analysis steps use only the primary assembly.

## Binning
Binning is performed with Blobtoolkit. The binning process utilizes multiple input files:
 - Raw assembly file (required)
 - Coverage file (optional)
 - Hits file (optional)
 - BUSCO completeness (optional)

### Coverage file
The coverage file (BAM format) was created using `minimap2.sh`.
This step involved mapping the sequencing reads back to the assembled genome to extract coverage depth information.

### Hits file
Hits file can be created with blastn or diamond blastx, we used `diamond.sh`.
For this project, we used diamond.sh to perform fast protein-based taxonomic classification, which provides a high-confidence approach to identifying potential contaminants or misassemblies.

### BUSCO completeness
To evaluate the completeness of our assembly, we used `busco.sh`, which compares the assembly against a database of conserved single-copy orthologs.
This step is crucial for assessing the quality and reliability of the assembly before proceeding with downstream analyses.

### Blobtools 
Before visualizing the data with BlobTools, we first generated the required BlobTools dataset using blobtools create. This step integrates the raw assembly, coverage data, taxonomic hits, and completeness metrics into a structured dataset that can be analyzed interactively.
To visualised blobtools interactive pages use the following command in your terminal:
`blobtools view --remote blobtools_folder`
This will initialize the viewer, and you should see an output similar to:
`Initializing viewer
View dataset at http://localhost:8001/view/blobtools_Stomb_hap1/dataset/blobtools_Stomb_hap1/blob
For remote access use:
    ssh -L 8001:127.0.0.1:8001 -L 8000:127.0.0.1:8000 username@remote_host`
    
This allows you to explore the BlobTools results interactively through a web-based interface, facilitating the inspection of taxonomic assignments and potential contaminants in the assembly.

### Filtering for Streptophyta with BlobTools
To filter the dataset and retain only sequences classified under the phylum Streptophyta, we applied filtering commands contained in `blobtools_filter.sh`.
After filtering the dataset for Streptophyta, we performed an additional quality check using `assemblathon_filter.sh`.
