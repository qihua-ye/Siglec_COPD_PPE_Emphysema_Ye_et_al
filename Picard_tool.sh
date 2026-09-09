#!/bin/sh

#SBATCH --nodes=1
#SBATCH --time=10:00:00
#SBATCH --account=amc-general
#SBATCH --partition=amilan
#SBATCH --qos=normal
#SBATCH --ntasks=20
#SBATCH --job-name=RNApicard
#SBATCH --mem=50G
#SBATCH --output=collectRNAseqMetrics_%J.log
#SBATCH --error=collectRNAseqMetrics_%J.err
#SBATCH --mail-user=qihua.ye@cuanschutz.edu
#SBATCH --mail-type=ALL

module load picard/2.27.5

alignment_dir=/scratch/alpine/qye@xsede.org/D3D7_STAR_Alignment_post_trim/
output_results_dir=/scratch/alpine/qye@xsede.org/D3D7_picard/
refFlat_ref_dir=/pl/active/courses/2024_fall/IMMU6110/data/bulk_RNA_seq/reference_data/mm10.refflat
library_strandedness=FIRST_READ_TRANSCRIPTION_STRAND
ribosomal_intervals_dir=/pl/active/courses/2024_fall/IMMU6110/data/bulk_RNA_seq/reference_data/mm10_primary_ribosomalRNA_interval_list.txt
store_temp_files_dir=/scratch/alpine/qye@xsede.org/D3D7_picard/

module load picard/2.27.5

picard CollectRnaSeqMetrics I=${alignment_dir}E150020212_L01_65_sortedAligned.sortedByCoord.out.bam O=E150020212_L01_65_collectRnaSeqMetricsPicard.txt REF_FLAT=${refFlat_ref_dir} STRAND=${library_strandedness} RIBOSOMAL_INTERVALS=${ribosomal_intervals_dir} TMP_DIR=${store_temp_files_dir}
