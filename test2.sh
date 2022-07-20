#!/bin/sh
#SBATCH -J  test           # Job name
#SBATCH -o  test.%j.out    # Name of stdout output file (%j expands to %jobId)
#SBATCH -t 1-00:00:00        # Run time (hh:mm:ss) 

#### Select  GPU
#SBATCH -p debug           # queue  name  or  partiton
#SBATCH   --nodes=1              # number of nodes
#SBATCH   --ntasks-per-node=1
#SBATCH   --cpus-per-task=1

cd  $SLURM_SUBMIT_DIR

echo "SLURM_SUBMIT_DIR=$SLURM_SUBMIT_DIR"
echo "CUDA_HOME=$CUDA_HOME"
echo "CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"
echo "CUDA_VERSION=$CUDA_VERSION"

module purge
module load anaconda3/2022.05
module load cuda/11.6

##  Python  Virtual Env ##    ⇒> 가상환경


echo "Start"
echo "condaPATH"

echo "source $HOME/anaconda3/etc/profile.d/conda.sh"
source /opt/anaconda3/2022.05/etc/profile.d/conda.sh    #경로

echo "conda activate SAM"
conda activate SAM
python3 sam.py
date

echo " condadeactivate tf-gpu-py36"

conda deactivate #마무리 deactivate

squeue--job $SLURM_JOBID

echo  "##### END #####"
