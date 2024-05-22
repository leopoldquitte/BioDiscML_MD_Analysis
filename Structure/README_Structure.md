This file describe the content of the folder "Structure"

"WT_wat*" files represents solvated complex of ACE2-RBD Wuhan strain
"O_wat*" files represents solvated complex of ACE2-RBD Omicron BA.1 strain
"O5_wat*" files represents solvated complex of ACE2-RBD Omicron BA.5 strain


.prmtop files stands for topology files
.inpcrd file stands for initial coordinates files
.pdb are proteins coordinates files used for visualization of the structures

leap_wat.in file is the script file that can be launched with tleap and produce the topology and initial coordinates files using as input the pdb structure from RCSPBD website :
    - Wuhan Strain PDB code : 6M0J
    - Omicron BA.1 PDB code : 7U0N
    - Omicron BA.5 PDB code : 7ZXU

The last Omicron BA.5 structure was then aligned on the Omicron BA.1 RBD structure in complex with ACE2 using Pymol in order to produce the complex structure ACE2-RBD Omicron BA.5


