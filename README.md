# S.tombeanensis-genome
Saxifraga tombeanensis genome assembly pipeline. 
Please note that all the annotated pipelines are suitable for fdalgrande@bio-orto, so if you're not using the server of the Botanical Garden of Padova you may have to change something.

## Quality Control
For quality control of PacBio HiFi reads we used [`FastQC.sh`](Quality%20Control/FastQC.sh).
Additionally, we performed k-mer distribution analysis using [`GenomeScope.sh`](Quality%20Control/GenomeScope.sh) to estimate genome size and heterozygosity.

## Raw Assembly
Initial raw assembly was done with [`hifiasm1.sh`](Raw%20Assembly/hifiasm1.sh).
We also used [`busco.sh`](Raw%20AAssembly/busco.sh) to assess assembly completeness and [`assemblathon.sh`](Raw%20Assembly/assemblathon.sh) to calculate a variety of assembly quality metrics.
From this point onwards, all subsequent analysis steps use only the primary assembly.

## Binning
Binning is performed with Blobtoolkit. The binning process utilizes multiple input files:
 - Raw assembly file (required)
 - Coverage file (optional)
 - Hits file (optional)
 - BUSCO completeness (optional)

### Coverage file
The coverage file (BAM format) was created using [`minimap2.sh`](Binning/minimap2.sh).
This step involved mapping the sequencing reads back to the assembled genome to extract coverage depth information.

### Hits file
Hits file can be created with blastn or diamond blastx, we used [`diamond.sh`](Binning/diamond.sh).
For this project, we used diamond.sh to perform fast protein-based taxonomic classification, which provides a high-confidence approach to identifying potential contaminants or misassemblies.

### BUSCO completeness
To evaluate the completeness of our assembly, we used [`busco.sh`](Raw%20AAssembly/busco.sh), which compares the assembly against a database of conserved single-copy orthologs.
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
To filter the dataset and retain only sequences classified under the phylum Streptophyta, we applied filtering commands contained in [`blobtools_filter.sh`](Binning/blobtools_filter.sh).
After filtering the dataset for Streptophyta, we performed an additional quality check using [`assemblathon_filter.sh`](Binning/assemblathon_filter.sh).

## Organelle assembly
The chloroplast and mitochondrial organellar genomes were assembled separately using OATK with species-specific databases and 

### Chloroplast Genome Assembly
OATK was used with the Saxifragales database (NCBI Taxonomy ID: 41946) to assemble the chloroplast genome from the high-quality sequencing reads.  
You can find the script for this step in [`chloroplast_oatk.sh`](Organelle%20Assembly/chloroplast_oatk.sh).
After running OATK to refine the chloroplast genome assembly, we used [`chloroplast_ptGAUL.sh`](Organelle%20Assembly/chloroplast_ptGAUL.sh)to further improve the assembly.
We visualized the assembly using Bandage, a tool for interactive visualization of genome assemblies.

### Mitochondrial Genome Assembly
OATK was used with the Eudicotyledons mitochondrial database (NCBI Taxonomy ID: 71240) to assemble the mitochondrial genome.
The script for this part is available in [`mitochondrion_oatk.sh`](Organelle%20Assembly/mitochondrion_oatk.sh).
Same approach was applied to the mitochondrial genome. After the initial steps, we used [`mitochondrion_ptGAUL.sh`](Organelle%20Assembly/mitochondrion_ptGAUL.sh) to assemble the mitochondrial genome, followed by the use of Bandage.

### Organelle Contig Removal
To ensure that the primary genome assembly contained only nuclear sequences, we filtered out contigs corresponding to organellar genomes. This was done using a BLAST-based approach `filter_organelles.sh`. 
This step resulted in a nuclear genome assembly free of organellar contamination, which was then used for downstream analyses.

### Post-Filtering Validation
After removing organelle-derived sequences, we reassessed the nuclear genome assembly to ensure its integrity. Completeness was verified [`busco_removed_organelles.sh`](Organelle%20Assembly/busco_removed_organelles.sh) and coverage data updated [`minimap2_removed_organelles.sh`](Organelle%20Assembly/minimap2_removed_organelles.sh). These files were incorporated to rerun [`blobtools_removed_organelles.sh`](Organelle%20Assembly/blobtools_removed_organelles.sh), ensuring an accurate reassessment of taxonomic classification.
Assembly metrics were recalculated with [`assemblathon_removed_organelles.sh`](Organelle%20Assembly/assemblathon_removed_organelles.sh) to confirm consistency. These steps ensured that the filtered genome remained high-quality and suitable for downstream analyses.

## Purge Haplotigs
To reduce haplotig contamination in the genome assembly, we used [`purge_haplotigs.sh`](Purge%20Haplotigs/purge_haplotigs.sh), a tool designed to identify and remove haplotigs based on read depth and heterozygosity. The tool classifies contigs into primary and redundant haplotigs, which are then purged to improve assembly quality.

## Final Validation
To evaluate the final assembly, we used [`busco_curated.sh`](Final%20Validation/busco_curated.sh) to assess genome completeness, [`assemblathon_curated.sh`](Final%20Validation/assemblathon_curated.sh) to calculate various assembly quality metrics and [`merqury.sh`](Final%20Validation/merqury.sh) to evaluate the accuracy of the assembly by comparing it to the expected k-mer distribution.

For consistency with the Saxifraga tombeanensis genome validation steps, we performed an additional run of [`blobtools_curated.sh`](Final%20Validation/blobtools_curated.sh) using updated coverage data from [`minimap2_curated.sh`](Final%20Validation/minimap2_curated.sh) and updated hits file [`diamond_curated.sh`](Final%20Validation/diamond_curated.sh).
