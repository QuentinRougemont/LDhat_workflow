#!/bin/bash
#SBATCH --time=12:45:00
#SBATCH --job-name=compress
#SBATCH --output=compress-%J.out
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=6

# Move to directory where job was submitted
cd $SLURM_SUBMIT_DIR

#load parallel if necessary

find . -type f -name '*.txt' | parallel gzip --best

exit
for i in $(find . -name "rates.txt") ; do gzip $i ; done
for i in $(find . -name "bounds.txt") ; do gzip $i ; done
for i in $(find . -name "type_table.txt") ; do gzip $i ; done
for i in $(find . -name "new_lk.txt") ; do gzip $i ; done
for i in $(find . -name "res.txt") ; do gzip $i ; done


