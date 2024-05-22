#!/bin/sh
#SBATCH --ntasks=512 
#SBATCH --mem-per-cpu=2000
#SBATCH --time=2:0:0
module purge
module load StdEnv/2020 gcc/9.3.0 cuda/11.4 openmpi/4.0.3 amber/20.12-20.15

prm=`ls *prmtop`
crd=`ls *inpcrd`
########################################### Minimisation Equilibration Heating ###################################
mpirun -np 20 sander.MPI  -O -i mini1.in -o mini1.out -p $prm -c $crd  -ref $crd -r mini1.rst -x mini1.trj -e mini1.ene

mpirun -np 20 sander.MPI  -O -i mini2.in -o mini2.out -p $prm -c mini1.rst  -ref mini1.rst -r mini2.rst -x mini2.trj -e mini2.ene

mpirun -np 20 sander.MPI  -O -i mini3.in -o mini3.out -p $prm -c mini2.rst  -ref mini2.rst -r mini3.rst -x mini3.trj -e mini3.ene

mpirun -np 20 sander.MPI  -O -i mini4.in -o mini4.out -p $prm -c mini3.rst  -ref mini3.rst -r mini4.rst -x mini4.trj -e mini4.ene

mpirun -np 20 sander.MPI  -O -i mini5.in -o mini5.out -p $prm -c mini4.rst  -ref mini4.rst -r mini5.rst -x mini5.trj -e mini5.ene

mpirun -np 20 sander.MPI  -O -i mini6.in -o mini6.out -p $prm -c mini5.rst  -ref mini5.rst -r mini6.rst -x mini6.trj -e mini6.ene

mpirun -np 20 sander.MPI  -O -i mini7.in -o mini7.out -p $prm -c mini6.rst  -ref mini6.rst -r mini7.rst -x mini7.trj -e mini7.ene

mpirun -np 20 sander.MPI  -O -i heat8.in -o heat8.out -p $prm -c mini7.rst -ref mini7.rst -r heat8.rst -x heat8.trj -e heat8.ene


mpirun -np 20 sander.MPI -O -i eq9.in -o eq9.out -p $prm -c heat8.rst -ref heat8.rst -r eq9.rst -x eq9.trj -e eq9.ene

mpirun -np 20 sander.MPI -O -i eq10.in -o eq10.out -p $prm -c eq9.rst -ref eq9.rst -r eq10.rst -x eq10.trj -e eq10.ene

mpirun -np 20 sander.MPI -O -i eq11.in -o eq11.out -p $prm -c eq10.rst -ref eq10.rst -r eq11.rst -x eq11.trj -e eq11.ene

mpirun -np 20 sander.MPI -O -i eq12.in -o eq12.out -p $prm -c eq11.rst -ref eq11.rst -r eq12.rst -x eq12.trj -e eq12.ene

awk -v OFS=',' 'NR==1 {print "NSTEP,ENERGY,RMS,GMAX"}/ENERGY/{getline; print $1','$2','$3','$4}' mini1.out > results_mini1.csv
awk -v OFS=',' 'NR==1 {print "NSTEP,ENERGY,RMS,GMAX"}/ENERGY/{getline; print $1','$2','$3','$4}' mini2.out > results_mini2.csv
awk -v OFS=',' 'NR==1 {print "NSTEP,ENERGY,RMS,GMAX"}/ENERGY/{getline; print $1','$2','$3','$4}' mini3.out > results_mini3.csv
awk -v OFS=',' 'NR==1 {print "NSTEP,ENERGY,RMS,GMAX"}/ENERGY/{getline; print $1','$2','$3','$4}' mini4.out > results_mini4.csv
awk -v OFS=',' 'NR==1 {print "NSTEP,ENERGY,RMS,GMAX"}/ENERGY/{getline; print $1','$2','$3','$4}' mini5.out > results_mini5.csv
awk -v OFS=',' 'NR==1 {print "NSTEP,ENERGY,RMS,GMAX"}/ENERGY/{getline; print $1','$2','$3','$4}' mini6.out > results_mini6.csv
awk -v OFS=',' 'NR==1 {print "NSTEP,ENERGY,RMS,GMAX"}/ENERGY/{getline; print $1','$2','$3','$4}' mini7.out > results_mini7.csv

grep -E "TEMP\(K\)|Etot" heat8.out | awk -v OFS="," 'NR==1 {print "NSTEP,TIME(PS),TEMP(K),PRESS,Etot,EKtot,EPtot"} /NSTEP/{ORS="" ;print $3,$6,$9,$12;getline;print "," ;print $3,$6,$9; print "\n" }' > results_heat8.csv

grep -E "TEMP\(K\)|Etot" eq9.out | awk -v OFS="," 'NR==1 {print "NSTEP,TIME(PS),TEMP(K),PRESS,Etot,EKtot,EPtot"} /NSTEP/{ORS="" ;print $3,$6,$9,$12;getline;print "," ;print $3,$6,$9; print "\n" }' > results_eq9.csv
grep -E "TEMP\(K\)|Etot" eq10out | awk -v OFS="," 'NR==1 {print "NSTEP,TIME(PS),TEMP(K),PRESS,Etot,EKtot,EPtot"} /NSTEP/{ORS="" ;print $3,$6,$9,$12;getline;print "," ;print $3,$6,$9; print "\n" }' > results_eq10.csv
grep -E "TEMP\(K\)|Etot" eq11.out | awk -v OFS="," 'NR==1 {print "NSTEP,TIME(PS),TEMP(K),PRESS,Etot,EKtot,EPtot"} /NSTEP/{ORS="" ;print $3,$6,$9,$12;getline;print "," ;print $3,$6,$9; print "\n" }' > results_eq11.csv
grep -E "TEMP\(K\)|Etot" eq12.out | awk -v OFS="," 'NR==1 {print "NSTEP,TIME(PS),TEMP(K),PRESS,Etot,EKtot,EPtot"} /NSTEP/{ORS="" ;print $3,$6,$9,$12;getline;print "," ;print $3,$6,$9; print "\n" }' > results_eq12.csv
jobinfo ${SLURM_JOBID}
infoincidentjob
exit
