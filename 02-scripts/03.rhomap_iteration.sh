#!/bin/bash

#Global var
id=$[ $1  ]

#Rhomap options 
iter=40000000
samp=5000
bpen=2
burn=1000000

cd batch_1.dataset."$id"/ 

rhomap -seq batch_1.dataset_"$id".ldhat.sites \
    -loc batch_1.dataset_"$id".ldhat.locs \
    -lk ../../../new_lk.txt  \
    -burn "$burn" \
     -its  "$iter" \
    -bpen "$bpen" \
    -samp "$samp" \
     -prefix rhomap_

