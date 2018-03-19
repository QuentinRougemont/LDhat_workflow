#!/usr/bin/env python
"""
Script to cut large list in concatenated list elements with
        overlapping options

Usage:
    ./<script.py> file size overlap

Where:
    file:     is the name of the input file
    size:     is the number of SNPs to keep
    overlap:  is the number of overlapping SNPs

"""

import sys

#external parameters
try:
    filename = sys.argv[1]
    size = int(sys.argv[2])      # user name, no need to transform since already a string
    overlap = int(sys.argv[3])  # in years, transform input into an integer (with `int`)
except:
    print(__doc__)
    sys.exit(1)

#general variables
#OUTFILE="fileout"
#function
def get_overlapped_chunks(text, chunksize, overlapsize):  
    return [ lines[a:a+chunksize] for a in range(0,len(lines), chunksize-overlapsize)]

lines = open(filename, 'r').readlines() # text as single line
#lines = str.split(text)

chunks = get_overlapped_chunks(lines, size, overlap)

length = len(chunks) 
filenames=[f"dataset_{x+1}" for x in range(length) ]

#write output
for chunk, files in zip(chunks, filenames):
    with open(files, 'w') as output:
        #chunk = map(lambda x: x+, chunk)
        output.write("".join(chunk))
        #output.write('\t')

#text.close()
