# SPARE
SPecies_Abundance_and_Reads_Extraction (SPARE)
SPARE is a tool to detect species abundance in a sequencing sample and extract reads in the sample based on taxonomy id. Illumina or PacBio sequencing data is acceptable to the tool. 

## Prerequisites
Nextflow is needed. The detail of installation can be found in https://github.com/nextflow-io/nextflow. For HiPerGator users, its installation is not needed.

Singularity/APPTAINER is needed. The detail of installation can be found in https://singularity-tutorial.github.io/01-installation/. For HiPerGator users, its installation is not needed.

SLURM is needed. For HiPerGator users, its installation is not needed.

Python3 and its package "biopython" are needed. The package installation can be found in https://biopython.org/wiki/Packages

The Kraken2/Bracken Refseq index--PlusPF is needed. Please download PlusPF index (over 77 GB) from the link (https://benlangmead.github.io/aws-indexes/k2) to the "PlusPF" folder in your local computer. And then extract the tar.gz archive. For HiPerGator users, its downloading is not needed. It has been downloaded and configed in the pipeline.

## How to detect species abundances in samples 
1. Put sequencing data in the folder "input".
   For Illumina sequencing, the data should be the paired-end, such as x_1.fastq.gz and x_2.fastq.gz.
   For PacBio sequencing, the data should be bam file and its index file, such as  x.bam and x.bam.pbi.    
2. Open the file "params.yaml", set the full paths of the parameters.     
   **input** : the full path to input dir of the pipeline in your computer. It looks like "/<full path to the pipeline dir in your computer>/input".     
   **output** : the full path to output dir of the pipeline in your computer. It looks like "/<full path to the pipeline dir in your computer>/output".
   **db** : the full path to kraken/bracken-database (PlusPF) in your computer. It looks like "/\<the full path to the parent dir of PlusPF foler in your computer\>/PlusPF". Its default setting is the path of PlusPF in HiPerGator cluster. For HiPerGator users, just keep default setting.     
3. Run command:              
   If input is bam file, 
   ```bash
   $sbatch spare bam
   ```
   If input is fastq file,
   ```bash
   $sbatch spare             
   ```
## How to extract reads
If you want to extract reads after the above step of species abundance detection, you can run the other command:
If data is single-end reads,
```bash
$sbatch extract_reads.sh single <taxonomy_id> <full path of kraken.out> <full path of read file>
```
If data is paired-end reads,
```bash
$sbatch extract_reads.sh pair <taxonomy_id> <full path of kraken.out> <full path of R1 read file> <full path of R2 read file>
```
