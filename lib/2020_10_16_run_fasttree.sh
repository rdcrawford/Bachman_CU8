#!/bin/sh 
#SBATCH --job-name=2020_10_16_run_fasttree
#SBATCH --mail-user=rcrawfo@umich.edu 
#SBATCH --mail-type=BEGIN,END 
#SBATCH --cpus-per-task=12 
#SBATCH --nodes=1 
#SBATCH --ntasks-per-node=1 
#SBATCH --mem-per-cpu=7900m 
#SBATCH --time=3-00:00:00 
#SBATCH --account=esnitkin1 
#SBATCH --partition=standard 
#SBATCH --output=/scratch/esnitkin_root/esnitkin/rcrawfo/Bachman_CU8/%x-%j.log 
 
cd //scratch/esnitkin_root/esnitkin/rcrawfo/Bachman_CU8/analysis/2020_10_16_cognac_aligments/
fasttree < Bachman_CU8_concatenated_gene_aa_alignment.fasta > Bachman_CU8_fastTree.tre
