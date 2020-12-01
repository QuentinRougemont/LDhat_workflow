#!/bin/bash
#PBS -A ihv-653-aa
#PBS -N OutputTest
##PBS -o OutTest.out
##PBS -e OutTest.err
#PBS -l walltime=8:00:00
#PBS -l nodes=1:ppn=8
#PBS -M quentinrougemont@orange.fr
##PBS -m ea 

cd "${PBS_O_WORKDIR}"

for i in $(find . -name "rates.txt") ; do gzip $i ; done
for i in $(find . -name "bounds.txt") ; do gzip $i ; done
for i in $(find . -name "type_table.txt") ; do gzip $i ; done
for i in $(find . -name "new_lk.txt") ; do gzip $i ; done
for i in $(find . -name "res.txt") ; do gzip $i ; done


