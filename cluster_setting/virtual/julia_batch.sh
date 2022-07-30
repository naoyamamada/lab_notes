#!/bin/bash
#SBATCH --job-name hostname
#SBATCH --output /archive/controller/logs/out/%x-%j.log
#SBATCH --error /archive/controller/logs/err/%x-%j.err
#SBATCH --cpus-per-task 1
#SBATCH --time 01:00
#SBATCH --partition main
sleep 30
singularity exec --bind /projects:/projects --bind /archive:/archive  --bind /archive:/archive /projects/controller/JuliaJulia.sif julia /projects/lab_notes/cluster_setting/virtual/julia_sample.jl $1
