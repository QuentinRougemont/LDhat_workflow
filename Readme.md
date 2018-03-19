# Quick and dirty pipeline for running LDhat.

# Purpose:

simple pipeline to run **LDhat** and estimates variable recombination rates

to obtain realistic results the pipeline simply splits whole genome data into
small chunk of 2,000 - 5,000 SNPs before runnig the different program from LDhat 

## Dependencies:

**LDhat** available [here](https://github.com/auton1/LDhat)

**vcftools** software available [here](https://github.com/vcftools/vcftools.git)

**python3.6**

**GNU parallel** (installed by default on most linux cluster)

## software installation

```bash

cd ../
git clone https://github.com/vcftools/vcftools.git
./autogen.sh
./configure --prefix=/path/to/vcftools/
make
make install

#then add path to bashrc or cp to bin

```

## Running the pipeline:

To fill

#### Please read the manual and LDhat papers before use

```

## References:

A. Auton and G. McVean. [Recombination rate estimation in the presence of hotspots](https://genome.cshlp.org/content/17/8/1219.long). Genome Res., 2007
