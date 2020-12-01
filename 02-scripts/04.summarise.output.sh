

#miniscript to concatenate the output from LDhat interval (previously run in block of 2K SNPs)
# into one file per chromosome  and one global file

list_chromosomes=$1 #list of the chromosome, one per line


for i in $(cat '$list_chromosomes')  ; 
do 
   ls -v  chromo.$i/02-LDHAT_maf/batch_1.dataset.*/res.txt.gz  |\
   xargs zcat |grep -v "\-1\.00" |\
   grep -v "Loci" > chromo.$i.results.txt  ; 
done 

for i in $(ls -v *results.txt ) ; 
do
   sed -i "s/^/$i\t/g" $i ;
done

ls -v chromo.*.results.txt |xargs cat > recomb.results.txt 

sed -i 's/chromo.//g' recomb.results.txt
sed -i 's/results.txt.//g' recomb.results.txt

for i in *txt ; do gzip $i ; done

