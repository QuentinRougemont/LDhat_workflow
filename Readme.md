# Quick and dirty pipeline for running LDhat.

# Purpose:

Simple pipeline to run **LDhat** and estimates variable recombination rates

To obtain realistic results the pipeline simply splits whole genome data into
small chunk of 2,000 - 5,000 SNPs before runnig the different program from LDhat 

## Dependencies:

**LDhat** available [here](https://github.com/auton1/LDhat)

**vcftools** software available [here](https://github.com/vcftools/vcftools.git)

**python3.6**

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

## Running the pipeline:

input needed: vcffile splitted by populations.
vcffile should be stored in `00-data` and named as follows:
batch."$pop".recode.vcf where "$pop" is the name of the target population

to create input files:
`./02-script/00-extract_data.sh population_name list_chromosome`

Running interval and rhomap
first make sure you have an appropriate lk file.
Such file can be obtained from `lkgen` or from running `complete`.

### Setting LDhat parameters:

Edit files `02.interval_iteration.sh` and  `03.rhomap_iteration.sh` 
in `02-scripts`
to choose appropriate MCMC length, etc. 


Then edit files `02-scripts/graham_cedar/04.interval_parallel_NC_arg.sh`
and `02-scripts/graham_cedar/05.rhomap_parallel_NC_arg.sh`
to match your cluster requirement.
end run the script

#### Please read the manual and LDhat papers before use

```

## References:

A. Auton and G. McVean. [Recombination rate estimation in the presence of hotspots](https://genome.cshlp.org/content/17/8/1219.long). Genome Res., 2007
