#!/usr/bin/bash
#SBATCH --account=bphl-umbrella
#SBATCH --qos=bphl-umbrella
#SBATCH --job-name=SPARE
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=300gb
#SBATCH --time=48:00:00
#SBATCH --output=spare.%j.out
#SBATCH --error=spare.err
#SBATCH --mail-user=<EMAIL>
#SBATCH --mail-type=FAIL,END

module load nextflow
#module load longqc
APPTAINER_CACHEDIR=./
export APPTAINER_CACHEDIR

if [ "$1" = "bam" ]; then
   nextflow run spare_bam.nf -params-file params.yaml

else
   nextflow run spare_fq.nf -params-file params.yaml

fi

#singularity exec docker://staphb/mlst:2.23.0 cp /mlst-2.23.0/db/pubmlst/neisseria/neisseria.txt ./
#singularity exec  docker://staphb/mlst:2.23.0 cp /mlst-2.23.0/db/pubmlst/hinfluenzae/hinfluenzae.txt ./
#nextflow run candidapb.nf -params-file params.yaml
#sort ./output/*/report.txt | uniq > ./output/sum_report.txt
#sed -i '/sampleID\tspeciesID/d' ./output/sum_report.txt
#sed -i '1i sampleID\tspeciesID_mash\tnearest_neighb_mash\tmash_distance\tspeciesID_kraken\tkraken_percent\tmlst_scheme\tmlst_st\tmlst_cc\tpmga_species\tserotype\tnum_clean_reads\tavg_readlength\tavg_read_qual\test_coverage\tnum_contigs\tlongest_contig\tN50\tL50\ttotal_length\tgc_content\tannotated_cds' ./output/sum_report.txt
#rm ./neisseria.txt
#rm ./hinfluenzae.txt

#mv ./*.out ./output
#mv ./*err ./output

dt=$(date "+%Y%m%d%H%M%S")
mv ./output ./output-$dt
#mv ./work ./work-$dt
#rm -r ./work
#rm -r ./cache