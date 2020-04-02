#!/bin/bash
#PBS -A ihv-653-aa
#PBS -N OutputTest
##PBS -o OutTest.out
##PBS -e OutTest.err
#PBS -l walltime=48:00:00
#PBS -l nodes=1:ppn=8
#PBS -M quentinrougemont@orange.fr
##PBS -m ea 

cd "${PBS_O_WORKDIR}"

list_chromo=chr

if [ -z "$list_chromo" ]
then
	echo "error!! need chromo list"
	exit
fi

BLU='\033[0;34m'
NC='\033[0m' 
NCPUS=10

for i in $(cat "$list_chromo")  ;
do 
	echo ${BLU}####################################${NC}  
	echo -e "\tmooving to chomo."$i" folder"  
	echo ${BLU}####################################${NC} 
	
	cd  chromo."$i"/02-LDHAT_maf/  
	
	seqid=$(ls -1 batch_1.dataset.*/*sites |wc -l )	
	seq $seqid |parallel -j $NCPUS ../../02-scripts/02.interval_iteration.sh
	
	cd ../../  
done 
