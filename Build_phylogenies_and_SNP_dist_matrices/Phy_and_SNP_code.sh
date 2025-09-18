# These analyses were using the Vermont Advanced Computing Center (VACC) at the University of Vermont for providing computational resources that have contributed to the research results reported within this paper. 
URL: http://www.uvm.edu/vacc
The scheduler is SLURM

# The first step is to build a multiple seqeunce alignment (MSA) from a multifasta file that includes all samples of interest, and the WuHan-1 (NC_045512.2) as an outgroup.

# I used a contanerized version of MAFFT,  to accomplish this

module load apptainer
apptainer pull docker://staphb/mafft:latest
apptainer pull docker://austinhpatton123/clipkit:latest
apptainer pull docker://staphb/iqtree:latest
apptainer pull docker://staphb/snp-sites:2.5.1


# generate MSA with MAFFT
apptainer exec mafft_latest.sif mafft sequences.fasta > sequences.aln.fasta

# Clean up alignment with ClipKIT
apptainer exec clipkit_latest.sif clipkit sequences.aln.fasta -m kpic-smart-gap

# generate a phylogenetic tree with iqtree
apptainer exec iqtree_latest.sif iqtree -s sequences.aln.fasta.clipkit -alrt 1000 -bb 1000


# make a matix of SNP site differences between samples
apptainer exec snp-sites_latest.sif snp-sites sequences.aln.fasta.clipkit
