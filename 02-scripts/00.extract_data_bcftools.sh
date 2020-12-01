#!/bin/bash

#input file = vcftools splitted by population
source /clumeq/bin/enable_cc_cvmfs
module load vcftools 
module load bcftools
module load python/3.7.4

#Global variables
MAF=0.05

if [ $# -ne 3 ]; then
    echo "USAGE: $0 vcffile popname chr_list"
    echo "Expecting the following values on the command line, in that order"
    echo "name of the vcf (compressed with bgzip and indexed)"
    echo "name of the population"
    echo "list of all wanted chromosomes"
    echo "example ./02-scripts/00.extract_data_bcftools.sh phased.vcf.gz population1 list_chromosome.txt"
    exit
fi

vcffile=$1
if [ -z "$vcffile" ]
then
    echo "STOP : I need a vcffile to work"
    echo exit
fi

pop=$2
if [ -z "$pop" ]
then
    echo "STOP : I need an input pop name"
    echo exit
fi

list_chromo=$3
if [ -z "$list_chromo" ]
then
    echo "STOP : list of chromo name needed"
    echo exit
fi

for i in $(cat "$list_chromo" ) ; do 
    mkdir -p "$pop"/chromo."$i"                      
    bcftools view -r $i ${vcffile} --min-af ${MAF} |\
         bgzip -c > "${pop}"/chromo."${i}"/batch."${pop}".$i.maf${MAF}.vcf.gz
    tabix -p vcf "${pop}"/chromo."${i}"/batch."${pop}".$i.maf${MAF}.vcf.gz
done

#create list of consecutive SNPs for LDhat
for i in $(cat "$list_chromo") 
do 
    cd "$pop"/chromo."$i" 
    input=batch."$pop"."$i".maf${MAF}.vcf.gz 
    size=5000 #$2
    overlap=500 # $3
    zcat "${input}" | grep -v "#" |cut -f 1-2 > list_position

    python ../../02-scripts/01.split_dataset.py \
    list_position \
    "$size" \
    "$overlap"

#Construct input files
    for j in dataset_* ; 
    do
        vcftools --gzvcf "$input" --positions $j --ldhat-geno --chr $i --out batch_1.$j 
    done
    cd ../../
done

#moove data to file
for i in $(cat "$list_chromo" ) ; 
do 
    mkdir "$pop"/chromo."$i"/02-LDHAT_maf
    cd "$pop"/chromo."$i"
    for j in $(seq $(ls dataset_* |wc -l)) ; 
    do 
        mkdir 02-LDHAT_maf/batch_1.dataset."$j" ; 
        mv batch_1.dataset_"$j".ldhat.locs   02-LDHAT_maf/batch_1.dataset."$j" 
        mv batch_1.dataset_"$j".ldhat.sites  02-LDHAT_maf/batch_1.dataset."$j" 
        mv batch_1.dataset_"$j".log  02-LDHAT_maf/batch_1.dataset."$j" 
    done
    cd ../../
done 
