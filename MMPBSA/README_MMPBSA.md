This file describe the files and how to use them in the "MMPBSA" folder

- 1_prep_mmpbsa.sh script file takes as input the topology file (md.prmtop) and produce three topology file as subdivision of the global system (complexe.prmtop , receptor.prmtop , ligand.prmtop) that will serve as input for the MMPBSA calculations
- mmpbsa.in file contains parameters for the energy calculation performed by the MMPBSA software 
- 2_MMPBSA.sh script file takes as input the previously generated topolgy file, the molecular dynamic topology file (md.prmtop), the trajectory file (md.nc) and the mmpbsa.in parameters file to produce energy calculation using MMPBSA program from AMBER18 software.
- Decomposition_per_aa.dat is an output of MMPBSA calculations presenting calculated energy term per residue of the system.
- energy_terms_per_frame.csv is an output of MMPBSA calculations presenting calculated energy term per frame of the molecular dynamics simulation.
- results_mmpbsa.dat is an output of MMPBSA calculations presenting global energy calculation of the molecular dynamic simulation.
