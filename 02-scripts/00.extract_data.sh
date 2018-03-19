#!/bin/bash

#input file = vcftools splitted by chromosome and by population
#the name of the pop should appears in the vcf name 
#the name of the chromosome should then appears in second

pop=$1

if [ -z "$pop" ]
then
	echo "############"
	echo "STOP : I need an input pop name"
	echo exit
fi

if [ -z "$list_chromo" ]
then
	echo "############"
	echo "STOP : list of chromo name needed"
	echo exit
fi

for i in $(cat "$list_chromo" ) ; do 
    
    vcftools --vcf  chromo."$i"/batch."$pop"."$i".recode.vcf \
    --maf 0.05 \
    --out chromo."$i"/batch."$pop"."$i".maf0.05 \
    --recode --recode-INFO-all
done

for i in $(cat "$list_chromo") 
do 
    cd chromo.$i 
    input=batch."$pop"."$i".maf0.05.recode.vcf 
    #input=batch."$pop".$i.recode.vcf
    size=5000 #$2
    overlap=500 # $3
    grep -v "#" "$input" |cut -f 1-2 > list_position

   ../02-scripts/01.split_dataset.py list_position "$size" "$overlap"

	for j in dataset_* ; 
	do
	    vcftools --vcf "$input" --positions $j --ldhat-geno --chr $i --out batch_1.$j 
	done
    cd ../
done

for i in $(cat "$list_chromo" ) ; 
do 
    mkdir chromo."$i"/02-LDHAT_maf
    cd chromo."$i"
    for j in $(seq $(ls dataset_* |wc -l)) ; 
    do 
        mkdir 02-LDHAT_maf/batch_1.dataset."$j" ; 
        mv batch_1.dataset_"$j".ldhat.locs   02-LDHAT_maf/batch_1.dataset."$j" 
        mv batch_1.dataset_"$j".ldhat.sites  02-LDHAT_maf/batch_1.dataset."$j" 
        mv batch_1.dataset_"$j".log  02-LDHAT_maf/batch_1.dataset."$j" 
    done
    cd ../
done 
