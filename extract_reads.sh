#!/usr/bin/bash
#SBATCH --account=bphl-umbrella
#SBATCH --qos=bphl-umbrella
#SBATCH --job-name=SPARE_extract
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=300gb
#SBATCH --time=48:00:00
#SBATCH --output=spare_extract.%j.out
#SBATCH --error=spare_extract.err
#SBATCH --mail-user=<EMAIL>
#SBATCH --mail-type=FAIL,END

file1=$(echo $4|rev|cut -d'/' -f1|rev|cut -d'.' -f1)
echo $file1
if [ "$1" = "single" ]; then
   mkdir ./extract
   python3 ./extract_kraken_reads.py -k $3 -s $4 -o ./extract/${file1}_$2.fq -t $2

elif [ "$1" = "pair" ]; then
   file2=$(echo $5|rev|cut -d'/' -f1|rev|cut -d'.' -f1)
   echo $file2
   mkdir ./extract

   python3 ./extract_kraken_reads.py -k $3 -s $4 -s2 $5 -o ./extract/${file1}_$2.fq -o2 ./extract/${file2}_$2.fq -t $2
else
   echo "If input is single-end read, the command should be '\$sbatch extract_reads.sh single <taxonomy_id> <full path of kraken.out> <full path of read file>' "
   echo "If input is paired-end, the command should be '\$sbatch extract_reads.sh pair <taxonomy_id> <full path of kraken.out> <full path of R1 read file> <full path of R2 read file>' "
fi