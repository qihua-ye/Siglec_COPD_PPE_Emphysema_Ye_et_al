# GSEA Workflow
# Author: Qihua "Kimmy" Ye
# DESeq2 version: [1.38.3]
# R version: [4.2.2]
# fgsea version: [1.24.0]
# msigdbr version: [7.5.1]
# Purpose: Run GSEA using DESeq2-derived differential expression and fgsea on mouse RNA-seq data

# Load Required Libraries
library(DESeq2)      # Differential expression analysis
library(fgsea)       # Fast GSEA
library(msigdbr)     # MSigDB gene sets for mouse
library(ggplot2)     # Visualization
library(pheatmap)     # Visualization
library(apeglm)        # LFC shrinkage

# ------------------------
# 1. Load Gene Count Files (Strandedness Counts) from KO and WT samples from naive (day 0) and day 21
# ------------------------


KO_d21_rep2 <-read.delim(file = "S:/BIOTECH/EvansLab/Data/Siglec KO Mice/SiglecF_PPE_Emphysema_PN14_Aged/DESeq_analysis/strandedness_counts/KO_d21_rep2_selected_strandedness_counts.txt", 
                         header = T,
                         sep = "",
                         dec = ".",
                         row.names = 1)
KO_d21_rep3 <-read.delim(file = "S:/BIOTECH/EvansLab/Data/Siglec KO Mice/SiglecF_PPE_Emphysema_PN14_Aged/DESeq_analysis/strandedness_counts/KO_d21_rep3_selected_strandedness_counts.txt", 
                         header = T,
                         sep = "",
                         dec = ".",
                         row.names = 1)
KO_d21_rep4 <-read.delim(file = "S:/BIOTECH/EvansLab/Data/Siglec KO Mice/SiglecF_PPE_Emphysema_PN14_Aged/DESeq_analysis/strandedness_counts/KO_d21_rep4_selected_strandedness_counts.txt", 
                         header = T,
                         sep = "",
                         dec = ".",
                         row.names = 1)
KO_d0_rep1 <-read.delim(file = "S:/BIOTECH/EvansLab/Data/Siglec KO Mice/SiglecF_PPE_Emphysema_PN14_Aged/DESeq_analysis/strandedness_counts/KO_naive_rep1_selected_strandedness_counts.txt", 
                        header = T,
                        sep = "",
                        dec = ".",
                        row.names = 1)
KO_d0_rep2 <-read.delim(file = "S:/BIOTECH/EvansLab/Data/Siglec KO Mice/SiglecF_PPE_Emphysema_PN14_Aged/DESeq_analysis/strandedness_counts/KO_naive_rep2_selected_strandedness_counts.txt", 
                        header = T,
                        sep = "",
                        dec = ".",
                        row.names = 1)
KO_d0_rep3 <-read.delim(file = "S:/BIOTECH/EvansLab/Data/Siglec KO Mice/SiglecF_PPE_Emphysema_PN14_Aged/DESeq_analysis/strandedness_counts/KO_naive_rep3_selected_strandedness_counts.txt", 
                        header = T,
                        sep = "",
                        dec = ".",
                        row.names = 1)
WT_d0_rep1 <-read.delim(file = "S:/BIOTECH/EvansLab/Data/Siglec KO Mice/SiglecF_PPE_Emphysema_PN14_Aged/DESeq_analysis/strandedness_counts/WT_naive_rep1_selected_strandedness_counts.txt", 
                        header = T,
                        sep = "",
                        dec = ".",
                        row.names = 1)
WT_d0_rep2 <-read.delim(file = "S:/BIOTECH/EvansLab/Data/Siglec KO Mice/SiglecF_PPE_Emphysema_PN14_Aged/DESeq_analysis/strandedness_counts/WT_naive_rep2_selected_strandedness_counts.txt", 
                        header = T,
                        sep = "",
                        dec = ".",
                        row.names = 1)
WT_d0_rep3 <-read.delim(file = "S:/BIOTECH/EvansLab/Data/Siglec KO Mice/SiglecF_PPE_Emphysema_PN14_Aged/DESeq_analysis/strandedness_counts/WT_naive_rep3_selected_strandedness_counts.txt", 
                        header = T,
                        sep = "",
                        dec = ".",
                        row.names = 1)
WT_d21_rep1 <-read.delim(file = "S:/BIOTECH/EvansLab/Data/Siglec KO Mice/SiglecF_PPE_Emphysema_PN14_Aged/DESeq_analysis/strandedness_counts/WT_d21_rep1_selected_strandedness_counts.txt", 
                         header = T,
                         sep = "",
                         dec = ".",
                         row.names = 1)
WT_d21_rep2 <-read.delim(file = "S:/BIOTECH/EvansLab/Data/Siglec KO Mice/SiglecF_PPE_Emphysema_PN14_Aged/DESeq_analysis/strandedness_counts/WT_d21_rep2_selected_strandedness_counts.txt", 
                         header = T,
                         sep = "",
                         dec = ".",
                         row.names = 1)
WT_d21_rep3 <- read.delim(file = "S:/BIOTECH/EvansLab/Data/Siglec KO Mice/SiglecF_PPE_Emphysema_PN14_Aged/DESeq_analysis/strandedness_counts/WT_d21_rep3_selected_strandedness_counts.txt",
                          header = T,
                          sep = "",
                          dec = ".",
                          row.names = 1)


# Combine all count matrices into one
Genecounts_MERGED <- cbind(WT_d0_rep1, WT_d0_rep2, WT_d0_rep3, KO_d0_rep1, KO_d0_rep2, KO_d0_rep3, WT_d21_rep1, WT_d21_rep2, WT_d21_rep3, KO_d21_rep2, KO_d21_rep3, KO_d21_rep4)
# ------------------------
# 2. Load Metadata
# ------------------------
metadata_MERGED <- read.csv("S:/BIOTECH/EvansLab/Data/Siglec KO Mice/SiglecF_PPE_Emphysema_PN14_Aged/DESeq_analysis/METADATA_FOR_RNASEQ_20260909.csv")
rownames(metadata_MERGED) <- metadata_MERGED$short_sample_ID

if (!all(rownames(metadata_MERGED) == colnames(Genecounts_MERGED))) {
  stop("Mismatch between metadata and gene counts column names!")
}

# ------------------------
# 3. Filter genes
# ------------------------
min_count <- 10
min_samples <- 10

Genes_to_keep <- rowSums(Genecounts_MERGED > min_count) >= min_samples
filteredGenecounts_MERGED <- Genecounts_MERGED[Genes_to_keep, ]

write.csv(filteredGenecounts_MERGED,
          file = "filteredGeneCountsStrandedness_MERGED.csv",
          quote = FALSE)

# ------------------------
# 4. Create and Normalize DESeq2 Dataset
# ------------------------
deData_MERGED <- DESeqDataSetFromMatrix(countData = filteredGenecounts_MERGED,
                                        colData = metadata_MERGED,
                                        design = ~ Sex + genotype_and_treatment)
deData_MERGED <- DESeq(deData_MERGED)

# Save normalized and raw counts
normcountsDf_MERGED <- counts(deData_MERGED, normalized = TRUE)
rawcountsDf_MERGED <- counts(deData_MERGED, normalized = FALSE)

# Save normalized counts to CSV
write.csv(normcountsDf_MERGED,
          file = "normalized_counts_MERGED.csv",
          quote = FALSE)

# Save raw counts to CSV
write.csv(rawcountsDf_MERGED,
          file = "raw_counts_MERGED.csv",
          quote = FALSE)


# ------------------------
# 5. Load MSigDB Gene Sets for Mouse (H, C2, GO:BP)
# ------------------------
msigdb_mouse <- msigdbr(species = "Mus musculus")

gene_sets_H <- split(msigdb_mouse[msigdb_mouse$gs_cat == "H", ]$gene_symbol,
                     msigdb_mouse[msigdb_mouse$gs_cat == "H", ]$gs_name)
C2_cp_subcats <- c("CP:KEGG", "CP:REACTOME")
msigdb_C2_CP <- msigdb_mouse[msigdb_mouse$gs_cat == "C2" & msigdb_mouse$gs_subcat %in% C2_cp_subcats, ]
gene_sets_C2_CP <- split(msigdb_C2_CP$gene_symbol, msigdb_C2_CP$gs_name)
gene_sets_C5_BP <- split(msigdb_mouse[msigdb_mouse$gs_cat == "C5" & msigdb_mouse$gs_subcat == "GO:BP", ]$gene_symbol,
                         msigdb_mouse[msigdb_mouse$gs_cat == "C5" & msigdb_mouse$gs_subcat == "GO:BP", ]$gs_name)

# ------------------------
# 6. Shrink LFC and Extract DE Results
# ------------------------
shrink_lfc_apeglm <- function(deData_MERGED, ko_label, wt_label) {
  deData_MERGED$genotype_and_treatment <- relevel(deData_MERGED$genotype_and_treatment, ref = wt_label)
  deData_MERGED <- nbinomWaldTest(deData_MERGED)
  coef_name <- paste0("genotype_and_treatment_", ko_label, "_vs_", wt_label)
  res_raw <- results(deData_MERGED, contrast = c("genotype_and_treatment", ko_label, wt_label))
  res_shrunk <- lfcShrink(deData_MERGED, coef = coef_name, type = "apeglm", res = res_raw)
  list(raw = na.omit(res_raw), shrunk = na.omit(res_shrunk))
}

res_D0  <- shrink_lfc_apeglm(deData_MERGED, "KO_D0",  "WT_D0")
res_D21 <- shrink_lfc_apeglm(deData_MERGED, "KO_D21", "WT_D21")

# ------------------------
# 7. Extract DEG Lists
# ------------------------
DEGs_D0   <- res_D0$shrunk[res_D0$shrunk$padj < 0.05 & abs(res_D0$shrunk$log2FoldChange) > 1, ]
DEGs_D21  <- res_D21$shrunk[res_D21$shrunk$padj < 0.05 & abs(res_D21$shrunk$log2FoldChange) > 1, ]

write.csv(as.data.frame(DEGs_D0),  "DEGs_D0_shrunk.csv")
write.csv(as.data.frame(DEGs_D21), "DEGs_D21_shrunk.csv")

# ------------------------
# 8. Rank Genes for GSEA
# ------------------------
rank_genes <- function(res_object) {
  res_object <- res_object[!is.na(res_object$log2FoldChange), ]
  ranked <- res_object$log2FoldChange
  names(ranked) <- rownames(res_object)
  sort(ranked, decreasing = TRUE)
}

ranked_genes_D0  <- rank_genes(res_D0$shrunk)
ranked_genes_D21 <- rank_genes(res_D21$shrunk)

# ------------------------
# 9. Run Combined GSEA
# ------------------------
names(gene_sets_H)     <- paste0("HALLMARK_", names(gene_sets_H))
names(gene_sets_C2_CP) <- paste0("C2_CP_", names(gene_sets_C2_CP))
names(gene_sets_C5_BP) <- paste0("C5_BP_", names(gene_sets_C5_BP))

combined_gene_sets <- c(gene_sets_H, gene_sets_C2_CP, gene_sets_C5_BP)

run_fgsea_and_save <- function(ranked_genes, outfile) {
  result <- fgseaMultilevel(
    pathways = combined_gene_sets,
    stats    = ranked_genes,
    minSize  = 15,
    maxSize  = 500
  )
  result$leadingEdge <- vapply(result$leadingEdge, function(x) paste(x, collapse = ", "), character(1))
  write.csv(result, outfile, row.names = FALSE)
}

run_fgsea_and_save(ranked_genes_D0,  "GSEA_results_D0_H_C2CP_C5BP.csv")
run_fgsea_and_save(ranked_genes_D21, "GSEA_results_D21_H_C2CP_C5BP.csv")

# ------------------------
# 10. Save R Session
# ------------------------
save.image(file = "gsea_051325_annotated.RData")

######################

# ------------------------
# GSEA Leading Edge ComplexHeatmap visualization;heatmap reported in Figure 6A 
# ------------------------

# Load Required Libraries
library(DESeq2)
library(fgsea)
library(msigdbr)
library(ggplot2)
library(apeglm)
library(ComplexHeatmap)
library(circlize)
library(dplyr)
library(tibble)
library(RColorBrewer)
library(colorspace)

# ------------------------
# 1. Load GSEA Results
# ------------------------
gsea_D0  <- read.csv("GSEA_results_D0_H_C2CP_C5BP.csv")
gsea_D21 <- read.csv("GSEA_results_D21_H_C2CP_C5BP.csv")

gsea_list <- list(D0 = gsea_D0, D21 = gsea_D21)

# ------------------------
# 2. Select pathway of interest: ECM degradation
# ------------------------
selected_pathways_list <- list(
  D0 = c(
    "C2_CP_REACTOME_DEGRADATION_OF_THE_EXTRACELLULAR_MATRIX"
  ),
  D21 = c(
    "C2_CP_REACTOME_DEGRADATION_OF_THE_EXTRACELLULAR_MATRIX"
  )
)

# ------------------------
# 3. Collapse Leading Edge Genes
# ------------------------
collapsed_map <- list()
first_timepoint <- list()
gene_time_map <- list()

for (tp in names(selected_pathways_list)) {
  gsea_df <- gsea_list[[tp]]
  for (pathway in selected_pathways_list[[tp]]) {
    row <- gsea_df[gsea_df$pathway == pathway, ]
    if (nrow(row) == 0) next
    
    genes <- unlist(strsplit(row$leadingEdge, ",\\s*"))
    
    if (is.null(collapsed_map[[pathway]])) {
      collapsed_map[[pathway]] <- genes
      first_timepoint[[pathway]] <- tp
    } else {
      collapsed_map[[pathway]] <- unique(c(collapsed_map[[pathway]], genes))
    }
    
    for (g in genes) {
      gene_time_map[[g]] <- unique(c(gene_time_map[[g]], tp))
    }
  }
}

# ------------------------
# 4. Prepare Gene-Level Data Frame
# ------------------------
gene_to_pathway_df <- stack(collapsed_map)
colnames(gene_to_pathway_df) <- c("Gene", "Pathway")

top_genes_combined <- unique(unlist(collapsed_map))

leading_labels <- setNames(rep("", length(top_genes_combined)), top_genes_combined)
for (g in top_genes_combined) {
  leading_labels[g] <- g
}

# ------------------------
# 5. Annotate Samples
# ------------------------
annotation_col <- metadata_MERGED[, c("genotype", "time")]
colnames(annotation_col) <- c("Genotype", "Timepoint")
rownames(annotation_col) <- rownames(metadata_MERGED)
annotation_col$Timepoint <- factor(annotation_col$Timepoint, levels = c(0, 21), labels = c("D0", "D21"))
annotation_col <- annotation_col[order(annotation_col$Timepoint, annotation_col$Genotype), ]

combined_split <- factor(
  paste(annotation_col$Timepoint, annotation_col$Genotype, sep = "_"),
  levels = c("D0_WT", "D0_KO", "D21_WT", "D21_KO")
)

# ------------------------
# 6. Normalize Expression & Subset (Z-score)
# ------------------------
zscore_matrix <- t(scale(t(normcountsDf_MERGED)))
zscore_subset <- zscore_matrix[rownames(zscore_matrix) %in% top_genes_combined, ]
zscore_subset <- zscore_subset[, rownames(annotation_col)]

# ------------------------
# 7. Order Genes & Rename Pathways 
# ------------------------
gene_ordered_df <- gene_to_pathway_df %>%
  filter(Gene %in% rownames(zscore_subset)) %>%
  group_by(Gene) %>%
  dplyr::slice(1) %>%
  ungroup() %>%
  mutate(first_tp = unlist(first_timepoint[Pathway])) %>%
  mutate(first_tp = factor(first_tp, levels = c("D0", "D21")))

sort_by_d21 <- c("C2_CP_REACTOME_DEGRADATION_OF_THE_EXTRACELLULAR_MATRIX")

final_gene_order <- c()

for (p in unique(gene_ordered_df$Pathway)) {
  genes_in_p <- gene_ordered_df$Gene[gene_ordered_df$Pathway == p]
  expr_matrix <- zscore_subset[genes_in_p, ]
  
  if (p %in% sort_by_d21) {
    samples_D21_WT <- rownames(annotation_col)[annotation_col$Timepoint == "D21" & annotation_col$Genotype == "WT"]
    samples_D21_KO <- rownames(annotation_col)[annotation_col$Timepoint == "D21" & annotation_col$Genotype == "KO"]
    
    avg_WT_D21 <- rowMeans(expr_matrix[, samples_D21_WT, drop = FALSE])
    avg_KO_D21 <- rowMeans(expr_matrix[, samples_D21_KO, drop = FALSE])
    
    diff_D21 <- avg_KO_D21 - avg_WT_D21
    ordered_genes <- names(sort(abs(diff_D21), decreasing = TRUE))
    
  } else {
    if (length(genes_in_p) > 1) {
      d <- dist(expr_matrix, method = "euclidean")
      hc <- hclust(d, method = "complete")
      ordered_genes <- rownames(expr_matrix)[hc$order]
    } else {
      ordered_genes <- genes_in_p
    }
  }
  
  final_gene_order <- c(final_gene_order, ordered_genes)
}

# select top 7 genes by absolute effect size
final_gene_order <- head(final_gene_order, 7)

# Apply gene order
zscore_subset <- zscore_subset[final_gene_order, ]

gene_ordered_df <- gene_ordered_df %>%
  filter(Gene %in% final_gene_order) %>%
  arrange(match(Gene, final_gene_order))

pathway_name_map <- c(
  "C2_CP_REACTOME_DEGRADATION_OF_THE_EXTRACELLULAR_MATRIX" = "ECM Degradation"
)
gene_ordered_df$Pathway_Simple <- pathway_name_map[gene_ordered_df$Pathway]

row_split_factor <- factor(gene_ordered_df$Pathway_Simple, levels = unique(gene_ordered_df$Pathway_Simple))
names(row_split_factor) <- gene_ordered_df$Gene

# ------------------------
# 8. Annotate
# ------------------------
gene_ordered_df$Pathway_Simple <- as.character(gene_ordered_df$Pathway_Simple)

pathway_levels <- unique(gene_ordered_df$Pathway_Simple)
pathway_palette <- qualitative_hcl(
  n = length(pathway_levels),
  palette = "Dark 3"
)
names(pathway_palette) <- pathway_levels

row_ha <- rowAnnotation(
  Pathway = gene_ordered_df$Pathway_Simple,
  col = list(Pathway = pathway_palette),
  show_annotation_name = FALSE,
  show_legend = TRUE
)

col_ha <- HeatmapAnnotation(
  Timepoint = annotation_col$Timepoint,
  Genotype = annotation_col$Genotype,
  col = list(
    Timepoint = c(D0 = "#999999", D21 = "#009E73"),
    Genotype = c(KO = "#d12183", WT = "black")
  ),
  annotation_name_side = "right"
)

# ------------------------
# 9. Draw ComplexHeatmap
# ------------------------
pdf("leading_edge_complexheatmap.pdf", width = 10, height = 8, family = "sans")
Heatmap(zscore_subset,
        name = "Z-score",
        top_annotation = col_ha,
        left_annotation = row_ha,
        show_column_names = FALSE,
        cluster_rows = FALSE,
        cluster_columns = FALSE,
        column_title = NULL,
        column_split = combined_split,
        row_split = row_split_factor[rownames(zscore_subset)],
        row_gap = unit(1.5, "mm"),
        column_gap = unit(1.5, "mm"),
        col = colorRamp2(c(-2, 0, 2), c("#4A6B8A", "#F7F7F7", "#67001F")),
        row_names_side = "left",
        row_names_gp = gpar(fontsize = 11),
        row_names_max_width = unit(4, "cm"),
        row_title_gp = gpar(fontsize = 1, col = NA),
        heatmap_legend_param = list(title = "Z-score"),
        use_raster = FALSE)

dev.off()
save.image(file = "gsea_annotated.RData")

