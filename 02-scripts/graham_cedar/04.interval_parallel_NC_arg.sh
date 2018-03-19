#!/bin/bash
#SBATCH --account=youraccount
#SBATCH --time=08:45:00
#SBATCH --job-name=ldhat
#SBATCH --output=ldhat-%J.out
##SBATCH --array=1-33%33
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=32
##SBATCH --gres=cpu:32
##SBATCH --mail-user=yourmail
##PBS -l nodes=1:ppn=8
##SBATCH --mail-type=EA 

# Move to directory where job was submitted
cd $SLURM_SUBMIT_DIR

list_chromo=$1

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
	seq $seqid |parallel -j $NCPUS ../../02.interval_iteration.sh
	
	cd ../../  
done 
