#!/bin/bash
#SBATCH --account=def-blouis
#SBATCH --time=12:00:00
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
#cd $SLURM_SUBMIT_DIR
module load gnu-parallel/20180322
NCPUS=32

myseq=$1
#nchromo=$1 #number of chromosomes
#element_low=$2 #number to split on #since 40 CPUs this should be a mulitple of 40  
#element_high=$3 #upper bound to split on #
#if [ -z "$nchromo" ]
#then
#    echo "error!! need number of chromo "
#    exit
#fi
#seq "$element_low" "$element_high" |parallel -j $NCPUS ./00-scripts/01.complete.sh
cat "$myseq" |parallel -j $NCPUS ./00-scripts/01.complete.sh
