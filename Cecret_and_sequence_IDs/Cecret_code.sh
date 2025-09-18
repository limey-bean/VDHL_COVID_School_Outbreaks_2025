# Here is the code used to run the Cecret workflow on SLURM: https://github.com/UPHL-BioNGS/Cecret


module load apptainer
module load nextflow

nextflow pull UPHL-BioNGS/Cecret:3.7.20230725

nextflow run UPHL-BioNGS/Cecret -profile singularity --multifastas multifastas/
