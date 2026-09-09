# Analysis Pipelines for “Siglec-F Protects Against Elastase-Induced Lung Inflammation and Emphysema in Mice”

This repository contains the analysis pipelines used in the study:

Ye et al.  
Siglec-F Protects Against Elastase-Induced Lung Inflammation and Emphysema in Mice  
DOI: https://doi.org/10.1101/2025.09.16.674299

The purpose of this repository is to provide transparent, reproducible code for the bulk RNA-seq and histological image analyses described in the manuscript.

---

# bulk_RNA_seq_codes

## Overview

This section includes the complete pipeline that processes raw bulk RNA-seq reads to identify differentially expressed genes (DEGs) and enriched biological pathways when comparing wild-type (WT) vs. Siglec-F-knockout (KO) resident airspace macrophages (RAMs) at different time points following elastase-induced lung inflammation and emphysema.

---

### Relation to Manuscript

Quantitative outputs derived from bulk RNA-seq analyses are reported in Figure 5 of the manuscript.

---

## Bulk RNA-seq Experimental Details

- Sequencing platform: DNBSeq-T7 (MGI/Complete Genomics)
- Read type: Paired-end, 100 bp
- Depth: ~80 million total reads per sample
- Total samples: 27

---

### Workflow

- Adapter trimming and quality control
- Alignment to the mouse reference genome
- Strandness assessment
- Gene-level quantification
- Differential expression analysis
- Gene set enrichment analysis (GSEA)
- Visualization of key pathways

---

## Computational Methods

### Read Processing and Alignment
- Adapter trimming and quality filtering were performed using cutadapt (v4.2).
- Trimmed reads were aligned to the mouse reference genome GRCm38/mm10 using STAR (v2.7.10b).
- RNA-seq strandedness was assessed using Picard CollectRnaSeqMetrics (v2.27.5).

### Gene Quantification and Filtering
- Raw gene-level counts were filtered to retain genes with >10 raw counts in at least 10 of 27 samples.

### Differential Expression Analysis
- Normalization and differential expression analysis were performed using DESeq2 (v1.38.2) in R (v4.2.2).
- Effect sizes were shrunk prior to downstream analyses.

### Gene Set Enrichment Analysis
- GSEA was performed using fgsea (v1.24.0) based on ranked gene-level statistics from the full dataset rather than overrepresentation analysis (ORA) of a predefined DEG list.
- Gene sets tested included Hallmark (H), C2CP (curated canonical pathways), and C5BP (Gene Ontology biological processes).
- Selected pathways were visualized using ComplexHeatmap (v3.22) in R (v4.2.2).

---

## Repository Contents

| File | Description |
|------|-------------|
| `Trimming_Cutadapt_upload.sh` | Adapter trimming and quality filtering |
| `STAR_alignment_upload.sh` | Alignment to GRCm38/mm10 |
| `Picard_tool_upload.sh` | RNA-seq strandedness assessment |
| `deseq_gsea_rcode.R` | DESeq2 analysis, GSEA, and visualization |

---

## Expected Outputs

- Normalized count matrices
- DEG results at different time points
- GSEA results at different time points
- Pathway heatmaps reported in the manuscript

---

# Qupath_codes

## Overview

This section describes the quantitative histological image analysis pipeline used to quantify Mmp8 protein expression in lavaged airspace macrophages (AMs) from WT and KO mice at baseline and day 21 post-elastase.

---

### Relation to Manuscript

Quantification derived from this analysis is reported in Figure E7.

---

## Imaging Data Overview

- Input: IHC staining on cytospins of lavaged airspace macrophages  
- Target: Mmp8 (DAB)
- Imaging modality: Brightfield microscopy
- Microscope: Olympus BX63
- Magnification: 60×
- Quantification: 150–300 AMs per mouse
- Sample size: n = 4–5 mice per group

---

## Experimental Quantification Summary

- Mmp8 positivity was defined as punctate cytoplasmic granules with DAB-positive signal above background.
- Mmp8 positivity was determined by two independent, blinded investigators.
- The % of Mmp8-positive AMs was calculated per mouse as the number of positive AMs divided by the total number of AMs counted.
- Mmp8-positive area per cell was quantified using the same images in QuPath.

---

## Software Requirements

- QuPath (v0.4.4)

---

## Image Analysis Workflow

Image analysis in QuPath followed the workflow described in the manuscript:

- Images were analyzed using the H&E-DAB image type.
- Fixed nuclear, DAB, and background thresholds were defined using a representative positive sample and applied uniformly across all images.
- Cells were automatically detected across the full field of view based on optical density.
- Automated cell detection results were manually reviewed for accuracy.
- Subcellular analysis with DAB spot detection was used to estimate DAB-positive area per cell.

---

## QuPath Script Contents

The Groovy script `Qupath_cell_selection_and_subcellular_selection_dry_GitHub.groovy` performs automated cell detection across the full field of view, followed by DAB-based subcellular spot detection to quantify Mmp8-positive area on a per-cell basis. The script exports per-cell measurement data from QuPath for downstream statistical analysis.

The R script `Qupath_Mmp8_Data_Wrangling_Simplified.R` is used for post-processing of the QuPath output. Because the raw measurement tables exported from QuPath are hierarchical in structure, this script aggregates the data to calculate the summed Mmp8-positive area per cell, generating analysis-ready tables for statistical comparisons.

All scripts assume consistent image acquisition parameters and predefined threshold values applied uniformly across all samples.

---

## Expected Outputs

- Per-cell quantitative measurement tables (`.csv`)
- Mmp8-positive area per AM
- Summary metrics used for statistical analysis and figure generation in the manuscript

---

## Usage Notes

- Scripts are intended to be executed within an active QuPath project.
- Images must be imported using the H&E-DAB image type.
- Threshold values were fixed using a representative positive sample; adjustment may be required to account for staining variability across experimental batches.
- Manual review of automated cell detection is required to ensure accuracy.

---

## Data Availability

### Bulk RNA-seq Data
Raw bulk RNA-seq data are publicly available in the NCBI Gene Expression Omnibus (GEO):

GEO accession: GSE307353  
https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE307353

### Histological Imaging Data
Raw immunohistochemistry (IHC) images and QuPath-derived measurement data used for Mmp8 quantification are not deposited in a public repository due to file size and data management constraints. These data are available from the corresponding authors upon reasonable request.

---

## Citation

If you use this code, please cite:

Ye et al.  
Siglec-F Protects Against Elastase-Induced Lung Inflammation and Emphysema in Mice  
DOI: https://doi.org/10.1101/2025.09.16.674299

---

## Contact

For questions related to this repository, please contact:

- Qihua Ye – qihua.ye@cuanschutz.edu  
- Christopher Evans – christopher.evans@cuanschutz.edu
