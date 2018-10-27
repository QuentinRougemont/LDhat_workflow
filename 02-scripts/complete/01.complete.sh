#bin/bash

#global variable
id=$[ $1 ]

#cd element."$id"/

#path to complete 
#(I use full path because the complete command already exists on all cluster tested
path=/home/b/blouis/quentin/software/LDhat

#local variable for complete:
n=400 #$2
rhomax=100
npts=101
theta=0.001
split=5200

#mini script to run complete 
"$path"/complete -n  "$n" \
        -rhomax "$rhomax" \
        -n_pts "$npts" \
        -theta "$theta" \
        -split "$split" \
        -element "$id"
