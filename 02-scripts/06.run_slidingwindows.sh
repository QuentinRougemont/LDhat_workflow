#!/bin/bash

#script to compute 4Ner in windows 
#dependencies: python3
#external parameters
if [ $# -ne 1 ]; then
        echo "Expecting one single following  parameter  on the command line,"
	echo "size of the windows to compute average (in Kb)"
        echo "usage example ./06.run_slidingwindows.sh 250 to compute 4Ner in 250kb windows"
	echo "the data must have been generated with the script 05.summarise.output.sh"
else
        #Using values from the command line
        windowsize=$1    
        echo "windowsize=$windowsize"
fi

mkdir reshaped
for i in chromo.*gz ; do
zcat $i |cut -f 2- |gzip > reshaped/$i;
done

echo "compute average rho in windows of $windowsize kb"

cd reshaped
for i in chromo.* ; do
    python3 ../02-scripts/sliding_window.py $i $windowsize ${i%.results.txt.gz}.reshaped.$windowsize.kb ;
done
echo "now compressing and reshaping the result"

for i in *kb  ; do gzip $i ; done

mkdir simplified
for i in chromo.*.reshaped.$windowsize.kb.gz ; do
    zcat $i |sed "s/^/$i\t/g" |sed "s/.reshaped.$windowsize.kb//g" |sed "s/chromo.Okis//g"|gzip  > simplified/$i ;

#    zcat $i |sed "s/^/$i\t/g" |sed "s/.reshaped.$windowsize.kb//g" |sed "s/chromo.Okis//g"  > simplified/$i ;
done

echo "file is reshaped, compressing now"
ls -v simplified/*$windowsize.kb.gz |xargs zcat |sed "s/.gz//g" |gzip > POP.$windowsize.kb.gz
echo "input file read for analysis"

