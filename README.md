# Analysis Pipelines for “Siglec-F Protects Against Elastase-Induced Lung Inflammation and Emphysema in Mice”

This repository contains the analysis pipelines used in the study:

Ye et al.  
Siglec-F Protects Against Elastase-Induced Lung Inflammation and Emphysema in Mice  

The purpose of this repository is to provide transparent, reproducible code for the bulk RNA-seq analyses described in the manuscript.

---

# bulk_RNA_seq_codes

## Overview

This section includes the complete pipeline that processes raw bulk RNA-seq reads to identify differentially expressed genes (DEGs) and enriched biological pathways when comparing wild-type (WT) vs. Siglec-F-knockout (KO) resident airspace macrophages (RAMs) at naive state (day 0) and day 21 following elastase-induced lung inflammation and emphysema.

---

### Relation to Manuscript

Quantitative outputs derived from bulk RNA-seq analyses are reported in Figure 6 of the manuscript.

---

## Bulk RNA-seq Experimental Details

- Sequencing platform: DNBSeq-T7 (MGI/Complete Genomics)
- Read type: Paired-end, 100 bp
- Depth: ~80 million total reads per sample
- Total samples: 12

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
- Raw gene-level counts were filtered to retain genes with >10 raw counts in at least 10 of 12 samples.

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
| `Trimming_Cutadapt.sh` | Adapter trimming and quality filtering |
| `STAR_alignment.sh` | Alignment to GRCm38/mm10 |
| `Picard_tool.sh` | RNA-seq strandedness assessment |
| `deseq_gsea_rcode.R` | DESeq2 analysis, GSEA, and visualization |

---

## Expected Outputs

- Normalized count matrices
- DEG results at different time points
- GSEA results at different time points
- Pathway heatmaps reported in the manuscript


## Data Availability

### Bulk RNA-seq Data
Raw bulk RNA-seq data are publicly available in the NCBI Gene Expression Omnibus (GEO):

GEO accession: GSE307353  
https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE307353

---

## Citation

If you use this code, please cite:

Ye et al.  
Siglec-F Protects Against Elastase-Induced Lung Inflammation and Emphysema in Mice  

---

## Contact

For questions related to this repository, please contact:

- Qihua Ye – qihua.ye@cuanschutz.edu  
- Christopher Evans – christopher.evans@cuanschutz.edu
