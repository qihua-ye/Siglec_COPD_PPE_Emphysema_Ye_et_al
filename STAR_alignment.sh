#!/bin/sh

#SBATCH --nodes=2
#SBATCH --time=12:00:00
#SBATCH --account=amc-general
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --ntasks=20
#SBATCH --job-name=star
#SBATCH --mem=50G
#SBATCH --output=d21_star_trimmed_%J.log
#SBATCH --error=d21_star_trimmed_%J.err
#SBATCH --mail-user=qihua.ye@cuanschutz.edu
#SBATCH --mail-type=ALL

module load star/2.7.10b
trimmed_fastq_dir='/scratch/alpine/qye@xsede.org/D3D7_cutadapt/'
output_dir='/scratch/alpine/qye@xsede.org/D3D7_STAR_Alignment_post_trim/'
annotation_file='/pl/active/courses/2023_fall/IMMU6110/data/bulk_RNA_seq/reference_data/mm10.refGene.gtf'
genome_index_dir='/pl/active/EvansLab_PSCCM/WTvsSigFKO/mm10_index_100bp/'

STAR --runMode alignReads --runThreadN 20 --genomeDir ${genome_index_dir} --readFilesCommand zcat --readFilesIn ${trimmed_fastq_dir}E150020212_L01_65_1.fq.gz_trimmed.fastq.gz ${trimmed_fastq_dir}E150020212_L01_65_2.fq.gz_trimmed.fastq.gz --outFileNamePrefix ${output_dir}E150020212_L01_65_sorted --outSAMtype BAM SortedByCoordinate --sjdbOverhang 100 --sjdbGTFfeatureExon exon --quantMode TranscriptomeSAM GeneCounts

STAR --runMode alignReads --runThreadN 20 --genomeDir ${genome_index_dir} --readFilesCommand zcat --readFilesIn ${trimmed_fastq_dir}E150020212_L01_67_1.fq.gz_trimmed.fastq.gz ${trimmed_fastq_dir}E150020212_L01_67_2.fq.gz_trimmed.fastq.gz --outFileNamePrefix ${output_dir}E150020212_L01_67_sorted --outSAMtype BAM SortedByCoordinate --sjdbOverhang 100 --sjdbGTFfeatureExon exon --quantMode TranscriptomeSAM GeneCounts

STAR --runMode alignReads --runThreadN 20 --genomeDir ${genome_index_dir} --readFilesCommand zcat --readFilesIn ${trimmed_fastq_dir}E150020212_L01_68_1.fq.gz_trimmed.fastq.gz ${trimmed_fastq_dir}E150020212_L01_68_2.fq.gz_trimmed.fastq.gz --outFileNamePrefix ${output_dir}E150020212_L01_68_sorted --outSAMtype BAM SortedByCoordinate --sjdbOverhang 100 --sjdbGTFfeatureExon exon --quantMode TranscriptomeSAM GeneCounts

STAR --runMode alignReads --runThreadN 20 --genomeDir ${genome_index_dir} --readFilesCommand zcat --readFilesIn ${trimmed_fastq_dir}E150020212_L01_69_1.fq.gz_trimmed.fastq.gz ${trimmed_fastq_dir}E150020212_L01_69_2.fq.gz_trimmed.fastq.gz --outFileNamePrefix ${output_dir}E150020212_L01_69_sorted --outSAMtype BAM SortedByCoordinate --sjdbOverhang 100 --sjdbGTFfeatureExon exon --quantMode TranscriptomeSAM GeneCounts

STAR --runMode alignReads --runThreadN 20 --genomeDir ${genome_index_dir} --readFilesCommand zcat --readFilesIn ${trimmed_fastq_dir}E150020212_L01_70_1.fq.gz_trimmed.fastq.gz ${trimmed_fastq_dir}E150020212_L01_70_2.fq.gz_trimmed.fastq.gz --outFileNamePrefix ${output_dir}E150020212_L01_70_sorted --outSAMtype BAM SortedByCoordinate --sjdbOverhang 100 --sjdbGTFfeatureExon exon --quantMode TranscriptomeSAM GeneCounts

STAR --runMode alignReads --runThreadN 20 --genomeDir ${genome_index_dir} --readFilesCommand zcat --readFilesIn ${trimmed_fastq_dir}E150020212_L01_71_1.fq.gz_trimmed.fastq.gz ${trimmed_fastq_dir}E150020212_L01_71_2.fq.gz_trimmed.fastq.gz --outFileNamePrefix ${output_dir}E150020212_L01_71_sorted --outSAMtype BAM SortedByCoordinate --sjdbOverhang 100 --sjdbGTFfeatureExon exon --quantMode TranscriptomeSAM GeneCounts

STAR --runMode alignReads --runThreadN 20 --genomeDir ${genome_index_dir} --readFilesCommand zcat --readFilesIn ${trimmed_fastq_dir}E150020212_L01_73_1.fq.gz_trimmed.fastq.gz ${trimmed_fastq_dir}E150020212_L01_73_2.fq.gz_trimmed.fastq.gz --outFileNamePrefix ${output_dir}E150020212_L01_73_sorted --outSAMtype BAM SortedByCoordinate --sjdbOverhang 100 --sjdbGTFfeatureExon exon --quantMode TranscriptomeSAM GeneCounts

STAR --runMode alignReads --runThreadN 20 --genomeDir ${genome_index_dir} --readFilesCommand zcat --readFilesIn ${trimmed_fastq_dir}E150020212_L01_74_1.fq.gz_trimmed.fastq.gz ${trimmed_fastq_dir}E150020212_L01_74_2.fq.gz_trimmed.fastq.gz --outFileNamePrefix ${output_dir}E150020212_L01_74_sorted --outSAMtype BAM SortedByCoordinate --sjdbOverhang 100 --sjdbGTFfeatureExon exon --quantMode TranscriptomeSAM GeneCounts

STAR --runMode alignReads --runThreadN 20 --genomeDir ${genome_index_dir} --readFilesCommand zcat --readFilesIn ${trimmed_fastq_dir}E150020212_L01_75_1.fq.gz_trimmed.fastq.gz ${trimmed_fastq_dir}E150020212_L01_75_2.fq.gz_trimmed.fastq.gz --outFileNamePrefix ${output_dir}E150020212_L01_75_sorted --outSAMtype BAM SortedByCoordinate --sjdbOverhang 100 --sjdbGTFfeatureExon exon --quantMode TranscriptomeSAM GeneCounts

STAR --runMode alignReads --runThreadN 20 --genomeDir ${genome_index_dir} --readFilesCommand zcat --readFilesIn ${trimmed_fastq_dir}E150020212_L01_76_1.fq.gz_trimmed.fastq.gz ${trimmed_fastq_dir}E150020212_L01_76_2.fq.gz_trimmed.fastq.gz --outFileNamePrefix ${output_dir}E150020212_L01_76_sorted --outSAMtype BAM SortedByCoordinate --sjdbOverhang 100 --sjdbGTFfeatureExon exon --quantMode TranscriptomeSAM GeneCounts

STAR --runMode alignReads --runThreadN 20 --genomeDir ${genome_index_dir} --readFilesCommand zcat --readFilesIn ${trimmed_fastq_dir}E150020212_L01_77_1.fq.gz_trimmed.fastq.gz ${trimmed_fastq_dir}E150020212_L01_77_2.fq.gz_trimmed.fastq.gz --outFileNamePrefix ${output_dir}E150020212_L01_77_sorted --outSAMtype BAM SortedByCoordinate --sjdbOverhang 100 --sjdbGTFfeatureExon exon --quantMode TranscriptomeSAM GeneCounts

STAR --runMode alignReads --runThreadN 20 --genomeDir ${genome_index_dir} --readFilesCommand zcat --readFilesIn ${trimmed_fastq_dir}E150020212_L01_78_1.fq.gz_trimmed.fastq.gz ${trimmed_fastq_dir}E150020212_L01_78_2.fq.gz_trimmed.fastq.gz --outFileNamePrefix ${output_dir}E150020212_L01_78_sorted --outSAMtype BAM SortedByCoordinate --sjdbOverhang 100 --sjdbGTFfeatureExon exon --quantMode TranscriptomeSAM GeneCounts
STAR --runMode alignReads --runThreadN 20 --genomeDir ${genome_index_dir} --readFilesCommand zcat --readFilesIn ${trimmed_fastq_dir}E150020212_L01_79_1.fq.gz_trimmed.fastq.gz ${trimmed_fastq_dir}E150020212_L01_79_2.fq.gz_trimmed.fastq.gz --outFileNamePrefix ${output_dir}E150020212_L01_79_sorted --outSAMtype BAM SortedByCoordinate --sjdbOverhang 100 --sjdbGTFfeatureExon exon --quantMode TranscriptomeSAM GeneCounts
STAR --runMode alignReads --runThreadN 20 --genomeDir ${genome_index_dir} --readFilesCommand zcat --readFilesIn ${trimmed_fastq_dir}E150020212_L01_80_1.fq.gz_trimmed.fastq.gz ${trimmed_fastq_dir}E150020212_L01_80_2.fq.gz_trimmed.fastq.gz --outFileNamePrefix ${output_dir}E150020212_L01_80_sorted --outSAMtype BAM SortedByCoordinate --sjdbOverhang 100 --sjdbGTFfeatureExon exon --quantMode TranscriptomeSAM GeneCounts
STAR --runMode alignReads --runThreadN 20 --genomeDir ${genome_index_dir} --readFilesCommand zcat --readFilesIn ${trimmed_fastq_dir}E150020212_L01_86_1.fq.gz_trimmed.fastq.gz ${trimmed_fastq_dir}E150020212_L01_86_2.fq.gz_trimmed.fastq.gz --outFileNamePrefix ${output_dir}E150020212_L01_86_sorted --outSAMtype BAM SortedByCoordinate --sjdbOverhang 100 --sjdbGTFfeatureExon exon --quantMode TranscriptomeSAM GeneCounts
STAR --runMode alignReads --runThreadN 20 --genomeDir ${genome_index_dir} --readFilesCommand zcat --readFilesIn ${trimmed_fastq_dir}E150020212_L01_87_1.fq.gz_trimmed.fastq.gz ${trimmed_fastq_dir}E150020212_L01_87_2.fq.gz_trimmed.fastq.gz --outFileNamePrefix ${output_dir}E150020212_L01_87_sorted --outSAMtype BAM SortedByCoordinate --sjdbOverhang 100 --sjdbGTFfeatureExon exon --quantMode TranscriptomeSAM GeneCounts
STAR --runMode alignReads --runThreadN 20 --genomeDir ${genome_index_dir} --readFilesCommand zcat --readFilesIn ${trimmed_fastq_dir}E150020212_L01_88_1.fq.gz_trimmed.fastq.gz ${trimmed_fastq_dir}E150020212_L01_88_2.fq.gz_trimmed.fastq.gz --outFileNamePrefix ${output_dir}E150020212_L01_88_sorted --outSAMtype BAM SortedByCoordinate --sjdbOverhang 100 --sjdbGTFfeatureExon exon --quantMode TranscriptomeSAM GeneCounts
