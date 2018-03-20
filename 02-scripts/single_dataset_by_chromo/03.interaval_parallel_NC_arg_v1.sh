#!/bin/bash
#SBATCH -J "interval"
#SBATCH -o log_%j
#SBATCH -c 10
##SBATCH -p low-suspend
#SBATCH -p ibismax
#SBATCH -A ibismax
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=YOUREMAIL
#SBATCH --time=20-00:00
#SBATCH --mem=24G

# Move to directory where job was submitted
#cd $SLURM_SUBMIT_DIR

# External args
list_chromo=$1

if [ -z "$list_chromo" ]
then
	echo "error!! need chromo list"
	exit
fi

NCPUS=10

#launching interval in parallel	
#find "$pop"/"$list_chromo" |parallel -j $NCPUS ../03.interval_iteration.sh {}
cat "$list_chromo" |parallel -j $NCPUS ./02-scripts/03.interval_iteration.sh {}
