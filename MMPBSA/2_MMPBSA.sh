#!/bin/bash
#SBATCH -J "MM_OBA12"
#SBATCH --ntasks=32 
#SBATCH --mem-per-cpu=4000
#SBATCH --time=10:00:00
module purge
module load StdEnv/2020 gcc/9.3.0 openmpi/4.0.3 amber/20.9-20.15 scipy-stack
srun MMPBSA.py.MPI -O -eo ene.csv -deo dec.csv -i mmpbsa.in -o mmpbsa.dat -sp OBA_wat.prmtop -cp complex.prmtop -rp rec.prmtop -lp lig.prmtop -y ../../../../md1.nc

jobinfo ${SLURM_JOBID}
infoincidentjob
exit
