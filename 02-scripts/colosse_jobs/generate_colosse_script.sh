
list_chromosomes=$1 #list of each chromosome -- one by line

for i in $(cat $list_chromosomes ) ; 
do 
    cp 02-scripts/coloose_jobs/04.interval_parallel_NC_arg.sh 02-scripts/coloose_jobs/04.interval_parallel_$i.sh ; 
    sed -i "s/list_chromo=chr/list_chromo=$i/g" 02-scripts/coloose_jobs/04.interval_parallel_$i.sh
done 


