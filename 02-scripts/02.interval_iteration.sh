#!/bin/bash

#Global var
id=$[ $1  ]

#Interval options 
iter=30000000
samp=5000
 
echo  "       running $dataset with  $iter iterations"
echo  "       sampling every $samp iterations"
echo "##################################################################"

cd batch_1.dataset."$id"/ 

interval -seq batch_1.dataset_"$id".ldhat.sites \
     -loc batch_1.dataset_"$id".ldhat.locs \
    -lk ../../../new_lk.txt  \
    -its "$iter" \
    -bpen 5 \
    -samp "$samp"

echo "##################################################################"
echo -e "   summarising final Ne r estimates --\n\tburning 100 first iterations "
echo  "##################################################################"

stat -input rates.txt -burn 250 -loc batch_1.dataset_"$id".ldhat.locs
#/home/quentin/programs/LDhat/stat -input rates.txt -burn 250 -loc batch_1.dataset_"$id".ldhat.locs
