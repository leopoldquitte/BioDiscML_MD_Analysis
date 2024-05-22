#!/bin/bash
#SBATCH --ntasks=32 
#SBATCH --mem-per-cpu=8000 
#SBATCH --time=1:00:00
module purge
module load StdEnv/2020 gcc/9.3.0 openmpi/4.0.3 amber/20.9-20.15 scipy-stack

srun ante-MMPBSA.py -p ./complex.prmtop -c lig.prmtop -s :598-791 --radii=mbondi2
