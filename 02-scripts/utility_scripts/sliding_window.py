#!/usr/bin/env python3
"""Compute statistics for sliding window along chromosomes

Usage:
    <program> input_file window_size output_file
"""

# Modules
import sys

# Parsing user input
try:
    input_file = sys.argv[1]
    window_size = int(sys.argv[2])
    output_file = sys.argv[3]
except:
    print(__doc__)
    sys.exit(1)

# Read data
data = [x.split() for x in open(input_file).readlines()]

data_float = []
for d in data:
    data_float.append([float(x) for x in d])

min_pos = 0
max_pos = max(data_float)[0]

while min_pos < max_pos:
    left = min_pos
    right = min_pos + window_size
    center = (left + right) / 2.0
    window_data = [x for x in data_float if x[0] >= left and x[0] <= right]
    average = sum([x[1] for x in window_data]) / len(window_data)
    #print(left, center, right, len(window_data), average, sep="\t")
    print(left, center, right, len(window_data), average, sep="\t",file=open(output_file,"a"))
    
    min_pos += window_size
