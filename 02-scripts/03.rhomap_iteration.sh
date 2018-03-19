#!/bin/bash

#Global var
id=$[ $1  ]

#set color for log
RED='\033[0;31m'
NC='\033[0m'

#Rhomap options 
iter=40000000
samp=5000
bpen=2
burn=1000000

echo -e ${RED}##################################################################${NC}
echo  "	     	  running $dataset with  $iter iterations"
echo  "	     	  sampling every $samp iterations"
echo -e ${RED}##################################################################${NC}

cd batch_1.dataset."$id"/ 

rhomap -seq batch_1.dataset_"$id".ldhat.sites \
	 -loc batch_1.dataset_"$id".ldhat.locs \
	 -lk ../../../new_lk.txt  \
	 -burn "$burn" \
     -its  "$iter" \
	 -bpen "$bpen" \
	 -samp "$samp" \
     -prefix rhomap_

echo -e ${RED}##################################################################${NC}
echo -e "	summarising final Ne r estimates --\n\tburning 100 first iterations "
echo -e ${RED}##################################################################${NC}

#stat -input rates.txt -burn 250 -loc batch_1.dataset_"$id".ldhat.locs
