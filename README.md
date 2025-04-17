# Saxifraga tombeanensis genome assembly and annotation
This is the documatation providing all the code that was used for assembling and annotating the reference genome of Saxifraga tombeanensis. 
Please note that all the annotated pipelines are suitable for fdalgrande@bio-orto, so if you're not using the server of the Botanical Garden of Padova you may have to install the cited programs and their dependencies.

## Quality Control
PacBio HiFi reads were quality-checked with [`FastQC.sh`](Quality%20Control/FastQC.sh).
Additionally, we performed k-mer distribution analysis using [`GenomeScope.sh`](Quality%20Control/GenomeScope.sh) to estimate genome size, ploidy level and heterozygosity.

## Raw Assembly
We assembled reads with [`hifiasm1.sh`](Raw%20Assembly/hifiasm1.sh).
To assess the quality of the first assembly we used [`assemblathon.sh`](Raw%20Assembly/assemblathon.sh) to calculate assembly metrics. We assessed gene completeness of the assembly using [`busco.sh`](Raw%20Assembly/busco.sh). BUSCO uses metaeuk as a gene predictor and compares the genes found in the assembly against a database of conserved single-copy orthologs. 
From this point onwards, all steps were performed on the primary assembly.

## Binning
Binning is the process of grouping contigs based on shared characteristics, such as GC content, read coverage and taxonomic origin. In this case, we performed genome binning  to identify potential contaminant sequences and filter them out of the final assembly.
Binning was performed and visualized using BlobToolKit, an interactive tool that enables the integration and exploration of multiple data layers associated with genome assemblies.

The binning process in [`blobtools.sh`](Binning/blobtools.sh) utilizes several input files:
 - Raw assembly file (required)
 - Coverage file (optional)
 - Hits file (optional)
 - BUSCO completeness (optional)

### Coverage file
We created the coverage file (BAM format) using [`minimap2.sh`](Binning/minimap2.sh).
This step involves mapping the sequencing reads back to the assembled genome to extract coverage depth information.

### Hits file
Hits file can be created with either blastn or diamond blastx, we used [`diamond.sh`](Binning/diamond.sh) and the entire Swiss-prot database downloaded in July 2024. Diamond performs fast protein-based taxonomic classification, which provides a high-confidence approach to identifying potential contaminants.

### BUSCO completeness
We calculated BUSCO completeness with [`busco.sh`](Raw%20Assembly/busco.sh)

### Blobtools 
Before visualizing the data with BlobToolkit, we generated the required BlobDir using `blobtools.sh`. This step integrates the raw assembly, coverage data, taxonomic hits, and completeness metrics into a structured dataset that can be analyzed interactively.
Following, some brief instrutions will help users to visualize the `blobtools.sh` results.

To visualise blobtools interactive pages enter the following command in your terminal:
 `blobtools view --remote blobtools_folder`
This will initialize the viewer, and you should see an output similar to:  
 `Initializing viewer
 View dataset at http://localhost:8001/view/blobtools_Stomb_hap1/dataset/blobtools_Stomb_hap1/blob
 For remote access use:
 ssh -L 8001:127.0.0.1:8001 -L 8000:127.0.0.1:8000 username@remote_host`
Then open a new terminal window and access to the server via `ssh` using the command provided and copy-paste the http link in any browser to view the results.

This allows you to explore the BlobTools results interactively through a web-based interface, facilitating the inspection of taxonomic assignments and potential contaminants in the assembly.

### Filtering for Streptophyta with BlobTools
To filter the dataset and retain only sequences classified under the phylum Streptophyta, we applied filtering commands contained in [`blobtools_filter.sh`](Binning/blobtools_filter.sh).
Then we performed an additional quality check using [`assemblathon_filter.sh`](Binning/assemblathon_filter.sh).

## Organelle assembly
We assembled mitochondrial genome using OATK. We used both OATK and ptGAUL to produce an assembly of the chloroplast genome.

### Chloroplast Genome Assembly
OATK was used with the Saxifragales database (NCBI Taxonomy ID: 41946) to assemble the chloroplast genome from the high-quality sequencing reads.  
You can find the script for this step in [`chloroplast_oatk.sh`](Organelle%20Assembly/chloroplast_oatk.sh).
We also used [`chloroplast_ptGAUL.sh`](Organelle%20Assembly/chloroplast_ptGAUL.sh) to produce a plastid genome assembly.
We visualized the assemblies produced by OATK and ptGAUL using Bandage, a tool for interactive visualization of genome assemblies. The assembly with higher seqence depth was used for the next seps. 

### Mitochondrial Genome Assembly
We used OATK to assemble the mitochondrial genome downloading Eudicotyledons mitochondrial database (NCBI Taxonomy ID: 71240) .
The script for this part is available in [`mitochondrion_oatk.sh`](Organelle%20Assembly/mitochondrion_oatk.sh).
We visualized the assembly using Bandage.

### Organelle Contig Removal
To ensure that the primary genome assembly contained only nuclear sequences, we filtered out contigs belonging to organellar genomes. This was done using a BLAST-based approach `filter_organelles.sh`. 
This step resulted in a nuclear genome assembly free of organellar contamination, which was then used for downstream analyses.

### Post-Filtering Validation
After removing organelle-derived sequences, we reassessed the nuclear genome assembly to ensure its integrity. Completeness was verified [`busco_removed_organelles.sh`](Organelle%20Assembly/busco_removed_organelles.sh) and coverage data updated [`minimap2_removed_organelles.sh`](Organelle%20Assembly/minimap2_removed_organelles.sh). These files were incorporated to run [`blobtools_removed_organelles.sh`](Organelle%20Assembly/blobtools_removed_organelles.sh), ensuring an accurate reassessment of taxonomic classification.
New assembly metrics were calculated with [`assemblathon_removed_organelles.sh`](Organelle%20Assembly/assemblathon_removed_organelles.sh) to confirm consistency. These steps ensured that the filtered genome remained high-quality and suitable for downstream analyses.

## Purge Haplotigs
We removed redundant sequences and resolved heterozygous regions using [`purge_haplotigs.sh`](Purge%20Haplotigs). This tool identifies haplotigs (contigs representing alternative haplotypes) based on read depth and sequence similarity. The resulting assembly includes only the primary haplotype and is suitable for downstream analyses such as annotation.

## Final Validation
To evaluate the final assembly, we used [`busco_curated.sh`](Final%20Validation/busco_curated.sh) to assess genome completeness, [`assemblathon_curated.sh`](Final%20Validation/assemblathon_curated.sh) to calculate quality metrics and [`merqury.sh`](Final%20Validation/merqury.sh) to assess base-level accuracy by comparing the assembly to the expected k-mer distribution.

To ensure consistency with previous validation steps,  we performed an additional run of [`blobtools_curated.sh`](Final%20Validation/blobtools_curated.sh) using updated coverage data from [`minimap2_curated.sh`](Final%20Validation/minimap2_curated.sh) and updated hits file [`diamond_curated.sh`](Final%20Validation/diamond_curated.sh).

##  Annotation

### Masking
Before annotation with BRAKER3, we soft-masked the assembly by converting repetitive regions into lowercase letters using [`masking.sh`](Annotation/masking.sh). This step helps prevent repetitive elements from interfering with gene prediction.
