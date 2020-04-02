# Quick and dirty pipeline for running LDhat.

# Purpose

Simple pipeline to run **LDhat** and estimate variable recombination rates

To obtain realistic results, the pipeline splits whole genome data into
small chunk of 2,000 - 5,000 SNPs before running the different programs from LDhat 

## Dependencies

**LDhat** available [here](https://github.com/auton1/LDhat)

**bcftools** software available[here](https://samtools.github.io/bcftools/)

**vcftools** software available [here](https://github.com/vcftools/vcftools.git)

**python3**

**GNU parallel** (installed by default on most linux cluster)

## software installation

```bash

#ldhat:

make

#then add path to bashrc or cp to bin

#vcftools
git clone https://github.com/vcftools/vcftools.git
./autogen.sh
./configure --prefix=/path/to/vcftools/
make
make install

#then add path to bashrc or cp to bin

```

## Running the pipeline

input needed: vcf file splitted by populations. An example script to split by pop is available in `utility_scripts`

to create input files:
`./02-script/00-extract_data_bcftools.sh population_name list_chromosome`

#### Running interval and rhomap

first make sure you have an appropriate lk file (see manual)

Such file can be obtained from `lkgen` or from running `complete`.

### Setting LDhat parameters

Edit files `02.interval_iteration.sh` and  `03.rhomap_iteration.sh` 
in `02-scripts`

to choose appropriate MCMC length, and other relevand parameters. 


Then edit files

`02-scripts/graham_cedar/04.interval_parallel_NC_arg.sh` and 

`02-scripts/graham_cedar/05.rhomap_parallel_NC_arg.sh`

to match your cluster requirement end run the script

# Generating a lookup table

* please see very simple example scripts located in `02-scripts/complete/`

#### Please read the manual and LDhat papers before use

#To do:
* add angsd for estimating theta 



## References

A. Auton and G. McVean. [Recombination rate estimation in the presence of hotspots](https://genome.cshlp.org/content/17/8/1219.long). Genome Res., 2007
