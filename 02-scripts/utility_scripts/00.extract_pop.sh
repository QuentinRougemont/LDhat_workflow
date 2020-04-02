#!/bin/bash

source /clumeq/bin/enable_cc_cvmfs

module load vcftools
module load bcftools

VCF=$1         #indexed and compressed vcf.gz
list_pop=$2    #list of population one pop by line
VCF=$(basename $VCF )

#pop_map = folder containg list of pop

INFOLDER=00.data
if [ ! -d "$INFOLDER" ]
then 
    echo "creating out-dir"
    mkdir "$INFOLDER"
fi


for i in $(cat $list_pop) ; 
do
    bcftools view -S pop_map/pop.${i} ${VCF} |bgzip -c > ${INFOLDER}/${VCF%.vcf.gz}.${i}.vcf.gz 
    tabix -p vcf  ${INFOLDER}/${VCF%.vcf.gz}.${i}.vcf.gz
done 
