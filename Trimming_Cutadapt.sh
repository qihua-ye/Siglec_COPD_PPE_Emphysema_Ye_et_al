#!/bin/sh

#SBATCH --nodes=2
#SBATCH --time=20:00:00
#SBATCH --account=amc-general
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --ntasks=20
#SBATCH --job-name=cutadapt
#SBATCH --mem=20G
#SBATCH --output=WTvsSigFKO_D3D7_cutadapt_%J.log
#SBATCH --error=WTvsSigFKO_D3D7_cutadapt_%J.err
#SBATCH --mail-user=qihua.ye@cuanschutz.edu
#SBATCH --mail-type=ALL

module load cutadapt/4.2

output_dir='/scratch/alpine/qye@xsede.org/D3D7_cutadapt/'
input_dir='/scratch/alpine/qye@xsede.org/D3D7_raw_fastq/'

cutadapt -q 25 --minimum-length=10 --pair-filter=any -o ${output_dir}E150020212_L01_65_1.fq.gz_trimmed.fastq.gz -p ${output_dir}E150020212_L01_65_2.fq.gz_trimmed.fastq.gz ${input_dir}E150020212_L01_65_1.fq.gz ${input_dir}E150020212_L01_65_2.fq.gz
cutadapt -q 25 --minimum-length=10 --pair-filter=any -o ${output_dir}E150020212_L01_67_1.fq.gz_trimmed.fastq.gz -p ${output_dir}E150020212_L01_67_2.fq.gz_trimmed.fastq.gz ${input_dir}E150020212_L01_67_1.fq.gz ${input_dir}E150020212_L01_67_2.fq.gz
cutadapt -q 25 --minimum-length=10 --pair-filter=any -o ${output_dir}E150020212_L01_68_1.fq.gz_trimmed.fastq.gz -p ${output_dir}E150020212_L01_68_2.fq.gz_trimmed.fastq.gz ${input_dir}E150020212_L01_68_1.fq.gz ${input_dir}E150020212_L01_68_2.fq.gz
cutadapt -q 25 --minimum-length=10 --pair-filter=any -o ${output_dir}E150020212_L01_69_1.fq.gz_trimmed.fastq.gz -p ${output_dir}E150020212_L01_69_2.fq.gz_trimmed.fastq.gz ${input_dir}E150020212_L01_69_1.fq.gz ${input_dir}E150020212_L01_69_2.fq.gz
cutadapt -q 25 --minimum-length=10 --pair-filter=any -o ${output_dir}E150020212_L01_70_1.fq.gz_trimmed.fastq.gz -p ${output_dir}E150020212_L01_70_2.fq.gz_trimmed.fastq.gz ${input_dir}E150020212_L01_70_1.fq.gz ${input_dir}E150020212_L01_70_2.fq.gz
cutadapt -q 25 --minimum-length=10 --pair-filter=any -o ${output_dir}E150020212_L01_71_1.fq.gz_trimmed.fastq.gz -p ${output_dir}E150020212_L01_71_2.fq.gz_trimmed.fastq.gz ${input_dir}E150020212_L01_71_1.fq.gz ${input_dir}E150020212_L01_71_2.fq.gz
cutadapt -q 25 --minimum-length=10 --pair-filter=any -o ${output_dir}E150020212_L01_73_1.fq.gz_trimmed.fastq.gz -p ${output_dir}E150020212_L01_73_2.fq.gz_trimmed.fastq.gz ${input_dir}E150020212_L01_73_1.fq.gz ${input_dir}E150020212_L01_73_2.fq.gz
cutadapt -q 25 --minimum-length=10 --pair-filter=any -o ${output_dir}E150020212_L01_74_1.fq.gz_trimmed.fastq.gz -p ${output_dir}E150020212_L01_74_2.fq.gz_trimmed.fastq.gz ${input_dir}E150020212_L01_74_1.fq.gz ${input_dir}E150020212_L01_74_2.fq.gz
cutadapt -q 25 --minimum-length=10 --pair-filter=any -o ${output_dir}E150020212_L01_75_1.fq.gz_trimmed.fastq.gz -p ${output_dir}E150020212_L01_75_2.fq.gz_trimmed.fastq.gz ${input_dir}E150020212_L01_75_1.fq.gz ${input_dir}E150020212_L01_75_2.fq.gz
cutadapt -q 25 --minimum-length=10 --pair-filter=any -o ${output_dir}E150020212_L01_76_1.fq.gz_trimmed.fastq.gz -p ${output_dir}E150020212_L01_76_2.fq.gz_trimmed.fastq.gz ${input_dir}E150020212_L01_76_1.fq.gz ${input_dir}E150020212_L01_76_2.fq.gz
cutadapt -q 25 --minimum-length=10 --pair-filter=any -o ${output_dir}E150020212_L01_77_1.fq.gz_trimmed.fastq.gz -p ${output_dir}E150020212_L01_77_2.fq.gz_trimmed.fastq.gz ${input_dir}E150020212_L01_77_1.fq.gz ${input_dir}E150020212_L01_77_2.fq.gz
cutadapt -q 25 --minimum-length=10 --pair-filter=any -o ${output_dir}E150020212_L01_78_1.fq.gz_trimmed.fastq.gz -p ${output_dir}E150020212_L01_78_2.fq.gz_trimmed.fastq.gz ${input_dir}E150020212_L01_78_1.fq.gz ${input_dir}E150020212_L01_78_2.fq.gz
cutadapt -q 25 --minimum-length=10 --pair-filter=any -o ${output_dir}E150020212_L01_79_1.fq.gz_trimmed.fastq.gz -p ${output_dir}E150020212_L01_79_2.fq.gz_trimmed.fastq.gz ${input_dir}E150020212_L01_79_1.fq.gz ${input_dir}E150020212_L01_79_2.fq.gz
cutadapt -q 25 --minimum-length=10 --pair-filter=any -o ${output_dir}E150020212_L01_80_1.fq.gz_trimmed.fastq.gz -p ${output_dir}E150020212_L01_80_2.fq.gz_trimmed.fastq.gz ${input_dir}E150020212_L01_80_1.fq.gz ${input_dir}E150020212_L01_80_2.fq.gz
cutadapt -q 25 --minimum-length=10 --pair-filter=any -o ${output_dir}E150020212_L01_86_1.fq.gz_trimmed.fastq.gz -p ${output_dir}E150020212_L01_86_2.fq.gz_trimmed.fastq.gz ${input_dir}E150020212_L01_86_1.fq.gz ${input_dir}E150020212_L01_86_2.fq.gz
cutadapt -q 25 --minimum-length=10 --pair-filter=any -o ${output_dir}E150020212_L01_87_1.fq.gz_trimmed.fastq.gz -p ${output_dir}E150020212_L01_87_2.fq.gz_trimmed.fastq.gz ${input_dir}E150020212_L01_87_1.fq.gz ${input_dir}E150020212_L01_87_2.fq.gz
cutadapt -q 25 --minimum-length=10 --pair-filter=any -o ${output_dir}E150020212_L01_88_1.fq.gz_trimmed.fastq.gz -p ${output_dir}E150020212_L01_88_2.fq.gz_trimmed.fastq.gz ${input_dir}E150020212_L01_88_1.fq.gz ${input_dir}E150020212_L01_88_2.fq.gz
