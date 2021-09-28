#!/bin/bash
#SBATCH --account=youraccount
#SBATCH --time=08:45:00
#SBATCH --job-name=ldhat
#SBATCH --output=ldhat-%J.out
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=32

# Move to directory where job was submitted
cd $SLURM_SUBMIT_DIR

echo "WARNING MAKE SUR TO PROVIDE A LOOKUP TABLE"

list_chromo=$1

if [ -z "$list_chromo" ]
then
	echo "error!! need chromo list"
	exit
fi

NCPUS=10

for i in $(cat "$list_chromo")  ;
do 
	echo -e "\tmooving to chomo."$i" folder"  
	
	cd  chromo."$i"/02-LDHAT_maf/  
	
	#seqid=$(ls -1 batch_1.dataset.*/*sites |wc -l )	
	#seq $seqid |parallel -j $NCPUS ../../02-scripts/02.interval_iteration.sh
	ls batch_1.dataset.* -d  |sed 's/batch_1.dataset.//g' > seqid
	cat $seqid |parallel -j $NCPUS ../../02-scripts/02.interval_iteration.sh

	cd ../../  
done 
