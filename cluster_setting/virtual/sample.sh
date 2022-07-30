#!/bin/bash
#SBATCH --job-name hostname
#SBATCH --output /archive/controller/logs/out/%x-%j.log
#SBATCH --error /archive/controller/logs/err/%x-%j.err
#SBATCH --cpus-per-task 1
#SBATCH --time 01:00
#SBATCH --partition main
sleep 30
hostname_=hostname
time_='date +%T'
echo ${hostname_} >> /archive/controller/results/result_${time}
