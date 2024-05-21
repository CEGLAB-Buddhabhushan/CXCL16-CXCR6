CD69
chicken
chr16 LOC121106948
chr1 CD69L

mallard
ch17 LOC113845380
LOC101797323
LOC101796643
LOC113845374
LOC119718682
LOC119718681

LOC119718676

peigon
LOC102090584


final  
cd69
chicken	CD69L
mallard	LOC119718676
peigon 	LOC102090584

cd103
chicken	lost	
mallard	ITGAE
pegion	ITGAE

CD49a
ITGA1

## Ap - Cl commom genes
Ap.Cl.features <- c("ANKRD28", "AOAH", "BTG2", "CAPG", "CD8B", "FASLG", "GPR15", "GPR65", "HOPX", "ID2", "IFNG", "IL18RAP", "ITGA1", "ITGAE", "IVNS1ABP", "JAML", "JUN", "MAP3K8", "NFKBIZ", "NR4A1", "NR4A2", "NR4A3", "PFKFB3", "PTGER4", "SAMSN1", "SPRY1", "STOM", "TIPARP", "TNFAIP3")


###############
library(SingleR)
library(celldex)
library(Seurat)
library(tidyverse)
library(pheatmap)

# Input Data 10X CellRanger .HDF5 format --------------
Ap_data <- Read10X(data.dir = "./Anas_platyrhynchos_filtered_feature_bc_matrix/")
Ap.seurat <- CreateSeuratObject(counts = Ap_data)

# QC and Filtering -----------
# explore QC
Ap.seurat[["percent.mt"]] <- PercentageFeatureSet(Ap.seurat, pattern = "^MT-")
Ap.seurat.filtered <- subset(Ap.seurat, subset = nFeature_RNA > 200 & percent.mt < 10)




# It is a good practice to filter out cells with non-sufficient genes identified and genes with non-sufficient expression across cells.


# pre-process standard workflow ---------------
Ap.seurat.filtered <- NormalizeData(object = Ap.seurat.filtered)
Ap.seurat.filtered <- FindVariableFeatures(object = Ap.seurat.filtered, selection.method = "vst", nfeatures = 2000)
Ap.seurat.filtered <- ScaleData(object = Ap.seurat.filtered)
Ap.seurat.filtered <- RunPCA(object = Ap.seurat.filtered)
Ap.seurat.filtered <- FindNeighbors(object = Ap.seurat.filtered, dims = 1:20)
Ap.seurat.filtered <- FindClusters(object = Ap.seurat.filtered)
Ap.seurat.filtered <- RunUMAP(object = Ap.seurat.filtered, dims = 1:20)
App <- plot_density(Ap.seurat.filtered , c("LOC119718676", "ITGAE", "ITGA1"), joint = TRUE)
App + plot_layout(ncol = 1)
Ap_plot <- DimPlot(Ap.seurat.filtered , label = TRUE, repel = TRUE) / App[[4]]
# running steps above to get clusters
View(Ap.seurat.filtered@meta.data)
DimPlot(Ap.seurat.filtered, reduction = 'umap')

ref <- celldex::HumanPrimaryCellAtlasData()
Ap_counts <- GetAssayData(Ap.seurat.filtered, layer = 'counts')
pred <- SingleR(test = Ap_counts,
        ref = ref,
        labels = ref$label.main)
Ap.seurat.filtered$singleR.labels <- pred$labels[match(rownames(Ap.seurat.filtered@meta.data), rownames(pred))]
DimPlot(Ap.seurat.filtered, reduction = 'umap', group.by = 'singleR.labels')


# Annotation diagnostics ----------


# ...Based on the scores within cells -----------
pred
pred$scores

plotScoreHeatmap(pred)


# ...Based on deltas across cells ----------

plotDeltaDistribution(pred)




# ...Comparing to unsupervised clustering ------------

tab <- table(Assigned=pred$labels, Clusters=Ap.seurat.filtered$seurat_clusters)
pheatmap(log10(tab+10), color = colorRampPalette(c('white','blue'))(10))
###
choir
seurat_object <- Ap.seurat.filtered
Ap.seurat.choir <- CHOIR(seurat_object, n_cores = 32)
Ap.seurat.choir <- runCHOIRumap(Ap.seurat.choir, reduction = "P0_reduction")
plotCHOIR(Ap.seurat.choir, accuracy_scores = F, plot_nearest = F, legend = F)


plot_density(Ap.seurat.percent , c("ITGAE", "ITGA1", "LOC119718676"), joint = TRUE)

Ap.seurat.percent <- subset(Ap.seurat, subset = nFeature_RNA > 200 & percent.mt < 10)
Ap.seurat.percent <- NormalizeData(object = Ap.seurat.percent)

Ap.Percent_Expressing <- Percent_Expressing(seurat_object = Ap.seurat.percent, features = Ap.Cl.features)
plot <- DotPlot(object = Ap.seurat.percent, features =  Ap.Cl.features)
plot_data <- plot$data %>% 
  select(pct.exp, id)
