###scRNA_seq dove
library(SingleR)
library(celldex)
library(Seurat)
library(tidyverse)
library(pheatmap)
library(patchwork)
library(ggplot2)
library(Nebulosa)

# Input Data 10X CellRanger .HDF5 format --------------
Cl_data <- Read10X(data.dir = "./Columba_livia_filtered_feature_bc_matrix/")
Cl.seurat <- CreateSeuratObject(counts = Cl_data)

# QC and Filtering -----------
# explore QC
Cl.seurat[["percent.mt"]] <- PercentageFeatureSet(Cl.seurat, pattern = "^MT-")
Cl.seurat.filtered <- subset(Cl.seurat, subset = nFeature_RNA > 200 & percent.mt < 10)




# It is a good practice to filter out cells with non-sufficient genes identified and genes with non-sufficient expression across cells.


# pre-process standard workflow ---------------
Cl.seurat.filtered <- NormalizeData(object = Cl.seurat.filtered)
Cl.seurat.filtered <- FindVariableFeatures(object = Cl.seurat.filtered, selection.method = "vst", nfeatures = 2000)
Cl.seurat.filtered <- ScaleData(object = Cl.seurat.filtered)
Cl.seurat.filtered <- RunPCA(object = Cl.seurat.filtered)
Cl.seurat.filtered <- FindNeighbors(object = Cl.seurat.filtered, dims = 1:20)
Cl.seurat.filtered <- FindClusters(object = Cl.seurat.filtered)
Cl.seurat.filtered <- RunUMAP(object = Cl.seurat.filtered, dims = 1:20)

# running steps above to get clusters
View(Cl.seurat.filtered@meta.data)
DimPlot(Cl.seurat.filtered, reduction = 'umap')

ref <- celldex::HumanPrimaryCellAtlasData()
Cl_counts <- GetAssayData(Cl.seurat.filtered, slot = 'counts')
pred <- SingleR(test = Cl_counts,
        ref = ref,
        labels = ref$label.main)
Cl.seurat.filtered$singleR.labels <- pred$labels[match(rownames(Cl.seurat.filtered@meta.data), rownames(pred))]
DimPlot(Cl.seurat.filtered, reduction = 'umap', group.by = 'singleR.labels')


Clp <- plot_density(Cl.seurat.filtered, c("ITGAE", "ITGA1"), joint = TRUE)
Clp + plot_layout(ncol = 1)
Cl_plot <- DimPlot(Cl.seurat.filtered, label = TRUE, repel = TRUE) / Clp[[3]]

Cl.seurat.percent <- subset(Cl.seurat, subset = nFeature_RNA > 200 & percent.mt < 10)
Cl.seurat.percent <- NormalizeData(object = Cl.seurat.percent)

Cl.Percent_Expressing <- Percent_Expressing(seurat_object = Cl.seurat.percent, features = Ap.Cl.features)
plot <- DotPlot(object = Cl.seurat.percent, features =  c("ITGAE", "ITGA1", "LOC102090584"))
plot_data <- plot$data %>% 
  select(pct.exp, id)
  
  



######################### CHICKEN ####################

library(Seurat)
library(ggplot2)
library(tidyverse)
library(gridExtra)
library(scCustomize)

dirs <- list.dirs(path = './PRJNA834764/controlminus/', recursive = F, full.names = F)

for(x in dirs){
  name <- gsub('_filtered_feature_bc_matrix','', x)
  
  cts <- ReadMtx(mtx = paste0('./PRJNA834764/controlminus/',x,'/matrix.mtx.gz'),
          features = paste0('./PRJNA834764/controlminus/',x,'/features.tsv.gz'),
          cells = paste0('./PRJNA834764/controlminus/',x,'/barcodes.tsv.gz'))
  assign(name, CreateSeuratObject(counts = cts))
}
controlminus_selected_cell_ids <- ls()[1:4]
Gg.merged_seurat.controlminus <- merge(controlminus_SRR19061709, y = c(controlminus_SRR19061710,controlminus_SRR19061711, controlminus_SRR19061712),
      add.cell.ids = controlminus_selected_cell_ids,
      project = 'Chicken_lung_controlminus')

dirs <- list.dirs(path = './PRJNA834764/controlplus/', recursive = F, full.names = F)

for(x in dirs){
  name <- gsub('_filtered_feature_bc_matrix','', x)
  
  cts <- ReadMtx(mtx = paste0('./PRJNA834764/controlplus/',x,'/matrix.mtx.gz'),
          features = paste0('./PRJNA834764/controlplus/',x,'/features.tsv.gz'),
          cells = paste0('./PRJNA834764/controlplus/',x,'/barcodes.tsv.gz'))
  assign(name, CreateSeuratObject(counts = cts))
}
controlplus_selected_cell_ids <- ls()[6:9]
Gg.merged_seurat.controlplus <- merge(controlplus_SRR19061700, y = c(controlplus_SRR19061713,controlplus_SRR19061714,controlplus_SRR19061715),
      add.cell.ids = controlplus_selected_cell_ids,
      project = 'Chicken_lung_controlplus')
      
      
dirs <- list.dirs(path = './PRJNA834764/Herts33minus/', recursive = F, full.names = F)

for(x in dirs){
  name <- gsub('_filtered_feature_bc_matrix','', x)
  
  cts <- ReadMtx(mtx = paste0('./PRJNA834764/Herts33minus/',x,'/matrix.mtx.gz'),
          features = paste0('./PRJNA834764/Herts33minus/',x,'/features.tsv.gz'),
          cells = paste0('./PRJNA834764/Herts33minus/',x,'/barcodes.tsv.gz'))
  assign(name, CreateSeuratObject(counts = cts))
}
Herts33minus_selected_cell_ids <- ls()[15:18]
Gg.merged_seurat.Herts33minus <- merge(Herts33minus_SRR19061698, y = c(Herts33minus_SRR19061699,Herts33minus_SRR19061716,Herts33minus_SRR19061717),
      add.cell.ids = Herts33minus_selected_cell_ids,
      project = 'Chicken_lung_Herts33minus')
      
dirs <- list.dirs(path = './PRJNA834764/Herts33plus/', recursive = F, full.names = F)

for(x in dirs){
  name <- gsub('_filtered_feature_bc_matrix','', x)
  
  cts <- ReadMtx(mtx = paste0('./PRJNA834764/Herts33plus/',x,'/matrix.mtx.gz'),
          features = paste0('./PRJNA834764/Herts33plus/',x,'/features.tsv.gz'),
          cells = paste0('./PRJNA834764/Herts33plus/',x,'/barcodes.tsv.gz'))
  assign(name, CreateSeuratObject(counts = cts))
}
Herts33plus_selected_cell_ids <- ls()[21:24]
Gg.merged_seurat.Herts33plus <- merge(Herts33plus_SRR19061701, y = c(Herts33plus_SRR19061702,Herts33plus_SRR19061703,Herts33plus_SRR19061704),
      add.cell.ids = Herts33plus_selected_cell_ids,
      project = 'Chicken_lung_Herts33plus')

dirs <- list.dirs(path = './PRJNA834764/LaSotaminus/', recursive = F, full.names = F)

for(x in dirs){
  name <- gsub('_filtered_feature_bc_matrix','', x)
  
  cts <- ReadMtx(mtx = paste0('./PRJNA834764/LaSotaminus/',x,'/matrix.mtx.gz'),
          features = paste0('./PRJNA834764/LaSotaminus/',x,'/features.tsv.gz'),
          cells = paste0('./PRJNA834764/LaSotaminus/',x,'/barcodes.tsv.gz'))
  assign(name, CreateSeuratObject(counts = cts))
}
LaSotaminus_selected_cell_ids <- ls()[27:30]
Gg.merged_seurat.LaSotaminus <- merge(LaSotaminus_SRR19061694, y = c(LaSotaminus_SRR19061705,LaSotaminus_SRR19061706,LaSotaminus_SRR19061707),
      add.cell.ids = LaSotaminus_selected_cell_ids,
      project = 'Chicken_lung_LaSotaminus')

dirs <- list.dirs(path = './PRJNA834764/LaSotaplus/', recursive = F, full.names = F)

for(x in dirs){
  name <- gsub('_filtered_feature_bc_matrix','', x)
  
  cts <- ReadMtx(mtx = paste0('./PRJNA834764/LaSotaplus/',x,'/matrix.mtx.gz'),
          features = paste0('./PRJNA834764/LaSotaplus/',x,'/features.tsv.gz'),
          cells = paste0('./PRJNA834764/LaSotaplus/',x,'/barcodes.tsv.gz'))
  assign(name, CreateSeuratObject(counts = cts))
}
LaSotaplus_selected_cell_ids <- ls()[33:36]
Gg.merged_seurat.LaSotaplus <- merge(LaSotaplus_SRR19061695, y = c(LaSotaplus_SRR19061696,LaSotaplus_SRR19061697,LaSotaplus_SRR19061708),
      add.cell.ids = LaSotaplus_selected_cell_ids,
      project = 'Chicken_lung_LaSotaplus')


Gg.merged_seurat.controlminus$sample <- rownames(Gg.merged_seurat.controlminus@meta.data)
Gg.merged_seurat.controlminus@meta.data <- separate(Gg.merged_seurat.controlminus@meta.data, col = 'sample', into = c('Condition', 'Sample', 'Barcode'), 
         sep = '_')
         
Gg.merged_seurat.controlminus[["percent.mt"]] <- PercentageFeatureSet(Gg.merged_seurat.controlminus, pattern = "^MT-")
Gg.merged_seurat.controlminus.filtered <- subset(Gg.merged_seurat.controlminus, subset = nFeature_RNA > 200 & percent.mt < 10)

Gg.merged_seurat.controlminus.filtered <- NormalizeData(object = Gg.merged_seurat.controlminus.filtered)
Gg.merged_seurat.controlminus.filtered <- FindVariableFeatures(object = Gg.merged_seurat.controlminus.filtered, selection.method = "vst", nfeatures = 2000)
Gg.merged_seurat.controlminus.filtered <- ScaleData(object = Gg.merged_seurat.controlminus.filtered)
Gg.merged_seurat.controlminus.filtered <- RunPCA(object = Gg.merged_seurat.controlminus.filtered)

Gg.merged_seurat.controlminus.filtered <- FindNeighbors(object = Gg.merged_seurat.controlminus.filtered, dims = 1:20)
Gg.merged_seurat.controlminus.filtered <- FindClusters(object = Gg.merged_seurat.controlminus.filtered)
Gg.merged_seurat.controlminus.filtered <- RunUMAP(object = Gg.merged_seurat.controlminus.filtered, dims = 1:20)
p1 <- DimPlot(Gg.merged_seurat.controlminus.filtered, reduction = 'umap', group.by = 'Condition')
p2 <- DimPlot(Gg.merged_seurat.controlminus.filtered, reduction = 'umap', group.by = 'Sample')
obj.list <- SplitObject(Gg.merged_seurat.controlminus.filtered, split.by = 'Sample')
for(i in 1:length(obj.list)){
  obj.list[[i]] <- NormalizeData(object = obj.list[[i]])
  obj.list[[i]] <- FindVariableFeatures(object = obj.list[[i]], selection.method = "vst", nfeatures = 2000)
}


# select integration features
features <- SelectIntegrationFeatures(object.list = obj.list)

# find integration anchors (CCA)
controlminus.anchors <- FindIntegrationAnchors(object.list = obj.list, anchor.features = features)
Gg.seurat.controlminus.integrated <- IntegrateData(anchorset = controlminus.anchors )

Gg.seurat.LaSotaplus.integrated <- ScaleData(object = Gg.seurat.controlminus.integrated)
Gg.seurat.controlminus.integrated <- RunPCA(object = Gg.seurat.controlminus.integrated)


Gg.merged_seurat.controlplus$sample <- rownames(Gg.merged_seurat.controlplus@meta.data)
Gg.merged_seurat.controlplus@meta.data <- separate(Gg.merged_seurat.controlplus@meta.data, col = 'sample', into = c('Condition', 'Sample', 'Barcode'), 
         sep = '_')
         
Gg.merged_seurat.controlplus[["percent.mt"]] <- PercentageFeatureSet(Gg.merged_seurat.controlplus, pattern = "^MT-")
Gg.merged_seurat.controlplus.filtered <- subset(Gg.merged_seurat.controlplus, subset = nFeature_RNA > 200 & percent.mt < 10)

Gg.merged_seurat.controlplus.filtered <- NormalizeData(object = Gg.merged_seurat.controlplus.filtered)
Gg.merged_seurat.controlplus.filtered <- FindVariableFeatures(object = Gg.merged_seurat.controlplus.filtered, selection.method = "vst", nfeatures = 2000)
Gg.merged_seurat.controlplus.filtered <- ScaleData(object = Gg.merged_seurat.controlplus.filtered)
Gg.merged_seurat.controlplus.filtered <- RunPCA(object = Gg.merged_seurat.controlplus.filtered)

Gg.merged_seurat.controlplus.filtered <- FindNeighbors(object = Gg.merged_seurat.controlplus.filtered, dims = 1:20)
Gg.merged_seurat.controlplus.filtered <- FindClusters(object = Gg.merged_seurat.controlplus.filtered)
Gg.merged_seurat.controlplus.filtered <- RunUMAP(object = Gg.merged_seurat.controlplus.filtered, dims = 1:20)
p1 <- DimPlot(Gg.merged_seurat.controlplus.filtered, reduction = 'umap', group.by = 'Condition')
p2 <- DimPlot(Gg.merged_seurat.controlplus.filtered, reduction = 'umap', group.by = 'Sample')
obj.list <- SplitObject(Gg.merged_seurat.controlplus.filtered, split.by = 'Sample')
for(i in 1:length(obj.list)){
  obj.list[[i]] <- NormalizeData(object = obj.list[[i]])
  obj.list[[i]] <- FindVariableFeatures(object = obj.list[[i]], selection.method = "vst", nfeatures = 2000)
}


# select integration features
features <- SelectIntegrationFeatures(object.list = obj.list)

# find integration anchors (CCA)
controlplus.anchors <- FindIntegrationAnchors(object.list = obj.list, anchor.features = features)
Gg.seurat.controlplus.integrated <- IntegrateData(anchorset = controlplus.anchors)

Gg.seurat.controlplus.integrated <- ScaleData(object = Gg.seurat.controlplus.integrated)
Gg.seurat.controlplus.integrated <- RunPCA(object = Gg.seurat.controlplus.integrated)


Gg.merged_seurat.Herts33minus$sample <- rownames(Gg.merged_seurat.Herts33minus@meta.data)
Gg.merged_seurat.Herts33minus@meta.data <- separate(Gg.merged_seurat.Herts33minus@meta.data, col = 'sample', into = c('Condition', 'Sample', 'Barcode'), 
         sep = '_')
         
Gg.merged_seurat.Herts33minus[["percent.mt"]] <- PercentageFeatureSet(Gg.merged_seurat.Herts33minus, pattern = "^MT-")
Gg.merged_seurat.Herts33minus.filtered <- subset(Gg.merged_seurat.Herts33minus, subset = nFeature_RNA > 200 & percent.mt < 10)

Gg.merged_seurat.Herts33minus.filtered <- NormalizeData(object = Gg.merged_seurat.Herts33minus.filtered)
Gg.merged_seurat.Herts33minus.filtered <- FindVariableFeatures(object = Gg.merged_seurat.Herts33minus.filtered, selection.method = "vst", nfeatures = 2000)
Gg.merged_seurat.Herts33minus.filtered <- ScaleData(object = Gg.merged_seurat.Herts33minus.filtered)
Gg.merged_seurat.Herts33minus.filtered <- RunPCA(object = Gg.merged_seurat.Herts33minus.filtered)

Gg.merged_seurat.Herts33minus.filtered <- FindNeighbors(object = Gg.merged_seurat.Herts33minus.filtered, dims = 1:20)
Gg.merged_seurat.Herts33minus.filtered <- FindClusters(object = Gg.merged_seurat.Herts33minus.filtered)
Gg.merged_seurat.Herts33minus.filtered <- RunUMAP(object = Gg.merged_seurat.Herts33minus.filtered, dims = 1:20)
p1 <- DimPlot(Gg.merged_seurat.Herts33minus.filtered, reduction = 'umap', group.by = 'Condition')
p2 <- DimPlot(Gg.merged_seurat.Herts33minus.filtered, reduction = 'umap', group.by = 'Sample')
obj.list <- SplitObject(Gg.merged_seurat.Herts33minus.filtered, split.by = 'Sample')
for(i in 1:length(obj.list)){
  obj.list[[i]] <- NormalizeData(object = obj.list[[i]])
  obj.list[[i]] <- FindVariableFeatures(object = obj.list[[i]], selection.method = "vst", nfeatures = 2000)
}


# select integration features
features <- SelectIntegrationFeatures(object.list = obj.list)

# find integration anchors (CCA)
Herts33minus.anchors <- FindIntegrationAnchors(object.list = obj.list, anchor.features = features)
Gg.seurat.Herts33minus.integrated <- IntegrateData(anchorset = Herts33minus.anchors)

Gg.seurat.Herts33minus.integrated <- ScaleData(object = Gg.seurat.Herts33minus.integrated)
Gg.seurat.Herts33minus.integrated <- RunPCA(object = Gg.seurat.Herts33minus.integrated)


Gg.merged_seurat.Herts33plus$sample <- rownames(Gg.merged_seurat.Herts33plus@meta.data)
Gg.merged_seurat.Herts33plus@meta.data <- separate(Gg.merged_seurat.Herts33plus@meta.data, col = 'sample', into = c('Condition', 'Sample', 'Barcode'), 
         sep = '_')
         
Gg.merged_seurat.Herts33plus[["percent.mt"]] <- PercentageFeatureSet(Gg.merged_seurat.Herts33plus, pattern = "^MT-")
Gg.merged_seurat.Herts33plus.filtered <- subset(Gg.merged_seurat.Herts33plus, subset = nFeature_RNA > 200 & percent.mt < 10)

Gg.merged_seurat.Herts33plus.filtered <- NormalizeData(object = Gg.merged_seurat.Herts33plus.filtered)
Gg.merged_seurat.Herts33plus.filtered <- FindVariableFeatures(object = Gg.merged_seurat.Herts33plus.filtered, selection.method = "vst", nfeatures = 2000)
Gg.merged_seurat.Herts33plus.filtered <- ScaleData(object = Gg.merged_seurat.Herts33plus.filtered)
Gg.merged_seurat.Herts33plus.filtered <- RunPCA(object = Gg.merged_seurat.Herts33plus.filtered)

Gg.merged_seurat.Herts33plus.filtered <- FindNeighbors(object = Gg.merged_seurat.Herts33plus.filtered, dims = 1:20)
Gg.merged_seurat.Herts33plus.filtered <- FindClusters(object = Gg.merged_seurat.Herts33plus.filtered)
Gg.merged_seurat.Herts33plus.filtered <- RunUMAP(object = Gg.merged_seurat.Herts33plus.filtered, dims = 1:20)
p1 <- DimPlot(Gg.merged_seurat.Herts33plus.filtered, reduction = 'umap', group.by = 'Condition')
p2 <- DimPlot(Gg.merged_seurat.Herts33plus.filtered, reduction = 'umap', group.by = 'Sample')
obj.list <- SplitObject(Gg.merged_seurat.Herts33plus.filtered, split.by = 'Sample')
for(i in 1:length(obj.list)){
  obj.list[[i]] <- NormalizeData(object = obj.list[[i]])
  obj.list[[i]] <- FindVariableFeatures(object = obj.list[[i]], selection.method = "vst", nfeatures = 2000)
}


# select integration features
features <- SelectIntegrationFeatures(object.list = obj.list)

# find integration anchors (CCA)
Herts33plus.anchors <- FindIntegrationAnchors(object.list = obj.list, anchor.features = features)
Gg.seurat.Herts33plus.integrated <- IntegrateData(anchorset = Herts33plus.anchors)

Gg.seurat.Herts33plus.integrated <- ScaleData(object = Gg.seurat.Herts33plus.integrated)
Gg.seurat.Herts33plus.integrated <- RunPCA(object = Gg.seurat.Herts33plus.integrated)


Gg.merged_seurat.LaSotaminus$sample <- rownames(Gg.merged_seurat.LaSotaminus@meta.data)
Gg.merged_seurat.LaSotaminus@meta.data <- separate(Gg.merged_seurat.LaSotaminus@meta.data, col = 'sample', into = c('Condition', 'Sample', 'Barcode'), 
         sep = '_')
         
Gg.merged_seurat.LaSotaminus[["percent.mt"]] <- PercentageFeatureSet(Gg.merged_seurat.LaSotaminus, pattern = "^MT-")
Gg.merged_seurat.LaSotaminus.filtered <- subset(Gg.merged_seurat.LaSotaminus, subset = nFeature_RNA > 200 & percent.mt < 10)

Gg.merged_seurat.LaSotaminus.filtered <- NormalizeData(object = Gg.merged_seurat.LaSotaminus.filtered)
Gg.merged_seurat.LaSotaminus.filtered <- FindVariableFeatures(object = Gg.merged_seurat.LaSotaminus.filtered, selection.method = "vst", nfeatures = 2000)
Gg.merged_seurat.LaSotaminus.filtered <- ScaleData(object = Gg.merged_seurat.LaSotaminus.filtered)
Gg.merged_seurat.LaSotaminus.filtered <- RunPCA(object = Gg.merged_seurat.LaSotaminus.filtered)

Gg.merged_seurat.LaSotaminus.filtered <- FindNeighbors(object = Gg.merged_seurat.LaSotaminus.filtered, dims = 1:20)
Gg.merged_seurat.LaSotaminus.filtered <- FindClusters(object = Gg.merged_seurat.LaSotaminus.filtered)
Gg.merged_seurat.LaSotaminus.filtered <- RunUMAP(object = Gg.merged_seurat.LaSotaminus.filtered, dims = 1:20)
p1 <- DimPlot(Gg.merged_seurat.LaSotaminus.filtered, reduction = 'umap', group.by = 'Condition')
p2 <- DimPlot(Gg.merged_seurat.LaSotaminus.filtered, reduction = 'umap', group.by = 'Sample')
obj.list <- SplitObject(Gg.merged_seurat.LaSotaminus.filtered, split.by = 'Sample')
for(i in 1:length(obj.list)){
  obj.list[[i]] <- NormalizeData(object = obj.list[[i]])
  obj.list[[i]] <- FindVariableFeatures(object = obj.list[[i]], selection.method = "vst", nfeatures = 2000)
}


# select integration features
features <- SelectIntegrationFeatures(object.list = obj.list)

# find integration anchors (CCA)
LaSotaminus.anchors <- FindIntegrationAnchors(object.list = obj.list, anchor.features = features)
Gg.seurat.LaSotaminus.integrated <- IntegrateData(anchorset = LaSotaminus.anchors)

Gg.seurat.LaSotaminus.integrated <- ScaleData(object = Gg.seurat.LaSotaminus.integrated)
Gg.seurat.LaSotaminus.integrated <- RunPCA(object = Gg.seurat.LaSotaminus.integrated)


Gg.merged_seurat.LaSotaplus$sample <- rownames(Gg.merged_seurat.LaSotaplus@meta.data)
Gg.merged_seurat.LaSotaplus@meta.data <- separate(Gg.merged_seurat.LaSotaplus@meta.data, col = 'sample', into = c('Condition', 'Sample', 'Barcode'), 
         sep = '_')
         
Gg.merged_seurat.LaSotaplus[["percent.mt"]] <- PercentageFeatureSet(Gg.merged_seurat.LaSotaplus, pattern = "^MT-")
Gg.merged_seurat.LaSotaplus.filtered <- subset(Gg.merged_seurat.LaSotaplus, subset = nFeature_RNA > 200 & percent.mt < 10)

Gg.merged_seurat.LaSotaplus.filtered <- NormalizeData(object = Gg.merged_seurat.LaSotaplus.filtered)
Gg.merged_seurat.LaSotaplus.filtered <- FindVariableFeatures(object = Gg.merged_seurat.LaSotaplus.filtered, selection.method = "vst", nfeatures = 2000)
Gg.merged_seurat.LaSotaplus.filtered <- ScaleData(object = Gg.merged_seurat.LaSotaplus.filtered)
Gg.merged_seurat.LaSotaplus.filtered <- RunPCA(object = Gg.merged_seurat.LaSotaplus.filtered)
#ElbowPlot(Gg.merged_seurat.LaSotaplus.filtered)

Gg.merged_seurat.LaSotaplus.filtered <- FindNeighbors(object = Gg.merged_seurat.LaSotaplus.filtered, dims = 1:20)
Gg.merged_seurat.LaSotaplus.filtered <- FindClusters(object = Gg.merged_seurat.LaSotaplus.filtered)
Gg.merged_seurat.LaSotaplus.filtered <- RunUMAP(object = Gg.merged_seurat.LaSotaplus.filtered, dims = 1:20)
p1 <- DimPlot(Gg.merged_seurat.LaSotaplus.filtered, reduction = 'umap', group.by = 'Condition')
p2 <- DimPlot(Gg.merged_seurat.LaSotaplus.filtered, reduction = 'umap', group.by = 'Sample')
obj.list <- SplitObject(Gg.merged_seurat.LaSotaplus.filtered, split.by = 'Sample')
for(i in 1:length(obj.list)){
  obj.list[[i]] <- NormalizeData(object = obj.list[[i]])
  obj.list[[i]] <- FindVariableFeatures(object = obj.list[[i]], selection.method = "vst", nfeatures = 2000)
}


# select integration features
features <- SelectIntegrationFeatures(object.list = obj.list)

# find integration anchors (CCA)
LaSotaplus.anchors <- FindIntegrationAnchors(object.list = obj.list, anchor.features = features)
Gg.seurat.LaSotaplus.integrated <- IntegrateData(anchorset = LaSotaplus.anchors)

Gg.seurat.LaSotaplus.integrated <- ScaleData(object = Gg.seurat.LaSotaplus.integrated)
Gg.seurat.LaSotaplus.integrated <- RunPCA(object = Gg.seurat.LaSotaplus.integrated)


Gg.seurat.controlminus.integrated
Gg.seurat.controlplus.integrated
Gg.seurat.Herts33minus.integrated
Gg.seurat.Herts33plus.integrated
Gg.seurat.LaSotaminus.integrated
Gg.seurat.LaSotaplus.integrated

Gg.seurat.controlminus.integrated <- RunUMAP(object = Gg.seurat.controlminus.integrated, dims = 1:20)
Gg.seurat.controlplus.integrated <- RunUMAP(object = Gg.seurat.controlplus.integrated, dims = 1:20)
Gg.seurat.Herts33minus.integrated <- RunUMAP(object = Gg.seurat.Herts33minus.integrated, dims = 1:20)
Gg.seurat.Herts33plus.integrated <- RunUMAP(object = Gg.seurat.Herts33plus.integrated, dims = 1:20)
Gg.seurat.LaSotaminus.integrated <- RunUMAP(object = Gg.seurat.LaSotaminus.integrated, dims = 1:20)
Gg.seurat.LaSotaplus.integrated <- RunUMAP(object = Gg.seurat.LaSotaplus.integrated, dims = 1:20)

p1 <- DimPlot(Gg.merged_seurat.LaSotaplus.filtered, reduction = 'umap', group.by = 'Condition')
p2 <- DimPlot(Gg.merged_seurat.LaSotaplus.filtered, reduction = 'umap', group.by = 'Sample')

p3 <- DimPlot(Gg.seurat.LaSotaplus.integrated, reduction = 'umap', group.by = 'Condition')
p4 <- DimPlot(Gg.seurat.LaSotaplus.integrated, reduction = 'umap', group.by = 'Sample')

Gg.merged_seurat.controlminus
Gg.merged_seurat.controlplus
Gg.merged_seurat.Herts33minus
Gg.merged_seurat.Herts33plus
Gg.merged_seurat.LaSotaminus
Gg.merged_seurat.LaSotaplus
Ap.Cl.features <- c("ANKRD28", "AOAH", "BTG2", "CAPG", "CD8B", "FASLG", "GPR15", "GPR65", "HOPX", "ID2", "IFNG", "IL18RAP", "ITGA1", "ITGAE", "IVNS1ABP", "JAML", "JUN", "MAP3K8", "NFKBIZ", "NR4A1", "NR4A2", "NR4A3", "PFKFB3", "PTGER4", "SAMSN1", "SPRY1", "STOM", "TIPARP", "TNFAIP3")

Gg.merged_seurat.controlminus.percent <- subset(Gg.merged_seurat.controlminus, subset = nFeature_RNA > 200 & percent.mt < 10)
Gg.merged_seurat.controlminus.percent <- NormalizeData(object = Gg.merged_seurat.controlminus.percent)
Gg.controlminus.Percent_Expressing <- Percent_Expressing(seurat_object = Gg.merged_seurat.controlminus.percent, features = Ap.Cl.features)

Gg.merged_seurat.controlplus.percent <- subset(Gg.merged_seurat.controlplus, subset = nFeature_RNA > 200 & percent.mt < 10)
Gg.merged_seurat.controlplus.percent <- NormalizeData(object = Gg.merged_seurat.controlplus.percent)
Gg.controlplus.Percent_Expressing <- Percent_Expressing(seurat_object = Gg.merged_seurat.controlplus.percent, features = Ap.Cl.features)

Gg.merged_seurat.Herts33minus.percent <- subset(Gg.merged_seurat.Herts33minus, subset = nFeature_RNA > 200 & percent.mt < 10)
Gg.merged_seurat.Herts33minus.percent <- NormalizeData(object = Gg.merged_seurat.Herts33minus.percent)
Gg.Herts33minus.Percent_Expressing <- Percent_Expressing(seurat_object = Gg.merged_seurat.Herts33minus.percent, features = Ap.Cl.features)


Gg.merged_seurat.Herts33plus.percent <- subset(Gg.merged_seurat.Herts33plus, subset = nFeature_RNA > 200 & percent.mt < 10)
Gg.merged_seurat.Herts33plus.percent <- NormalizeData(object = Gg.merged_seurat.Herts33plus.percent)
Gg.Herts33plus.Percent_Expressing <- Percent_Expressing(seurat_object = Gg.merged_seurat.Herts33plus.percent, features = Ap.Cl.features)

Gg.merged_seurat.LaSotaminus.percent <- subset(Gg.merged_seurat.LaSotaminus, subset = nFeature_RNA > 200 & percent.mt < 10)
Gg.merged_seurat.LaSotaminus.percent <- NormalizeData(object = Gg.merged_seurat.LaSotaminus.percent)
Gg.LaSotaminus.Percent_Expressing <- Percent_Expressing(seurat_object = Gg.merged_seurat.LaSotaminus.percent, features = Ap.Cl.features)

Gg.merged_seurat.LaSotaplus.percent <- subset(Gg.merged_seurat.LaSotaplus, subset = nFeature_RNA > 200 & percent.mt < 10)
Gg.merged_seurat.LaSotaplus.percent <- NormalizeData(object = Gg.merged_seurat.LaSotaplus.percent)
Gg.LaSotaplus.Percent_Expressing <- Percent_Expressing(seurat_object = Gg.merged_seurat.LaSotaplus.percent, features = Ap.Cl.features)

Gg.controlminus.Percent_Expressing
Gg.controlplus.Percent_Expressing
Gg.Herts33minus.Percent_Expressing
Gg.Herts33plus.Percent_Expressing
Gg.LaSotaminus.Percent_Expressing
Gg.LaSotaplus.Percent_Expressing

Ap.Percent_Expressing <- Percent_Expressing(seurat_object = Ap.seurat.percent, features = Ap.Cl.features)
Ap.Percent_Expressing$species <- "Ap"
Cl.Percent_Expressing <- Percent_Expressing(seurat_object = Cl.seurat.percent, features = Ap.Cl.features)
Cl.Percent_Expressing$species <- "Cl"
combined_df <- rbind(Ap.Percent_Expressing, Cl.Percent_Expressing, Gg.controlminus.Percent_Expressing, Gg.controlplus.Percent_Expressing, Gg.Herts33minus.Percent_Expressing, Gg.Herts33plus.Percent_Expressing, Gg.LaSotaminus.Percent_Expressing, Gg.LaSotaplus.Percent_Expressing)

###control CFAP74, CFAP54, CFAP221, CXCR4 and CXCR5
Ct_features <- c("CFAP74", "CFAP54", "CFAP221", "CXCR4", "CXCR5", "SPEF2","HYDIN")
mallard LOC101789892 
dove LOC102090584
chicken CD69L

Ap.Percent_Expressing.ct <- Percent_Expressing(seurat_object = Ap.seurat.percent, features = Ct_features)
Cl.Percent_Expressing.ct <- Percent_Expressing(seurat_object = Cl.seurat.percent, features = Ct_features)
Gg.controlminus.Percent_Expressing.ct <- Percent_Expressing(seurat_object = Gg.merged_seurat.controlminus.percent, features = Ct_features)
Gg.controlplus.Percent_Expressing.ct <- Percent_Expressing(seurat_object = Gg.merged_seurat.controlplus.percent, features = Ct_features)
Gg.Herts33minus.Percent_Expressing.ct <- Percent_Expressing(seurat_object = Gg.merged_seurat.Herts33minus.percent, features = Ct_features)
Gg.Herts33plus.Percent_Expressing.ct <- Percent_Expressing(seurat_object = Gg.merged_seurat.Herts33plus.percent, features = Ct_features)
Gg.LaSotaminus.Percent_Expressing.ct <- Percent_Expressing(seurat_object = Gg.merged_seurat.LaSotaminus.percent, features = Ct_features)
Gg.LaSotaplus.Percent_Expressing.ct <- Percent_Expressing(seurat_object = Gg.merged_seurat.LaSotaplus.percent, features = Ct_features)

DimPlot(Gg.seurat.LaSotaplus.integrated, reduction = 'umap', label = TRUE, repel = TRUE, label.size = 3.5) +NoLegend()

p4 <- plot_density(Gg.seurat.filtered, c( "ITGA1"), joint = TRUE)
p4 + plot_layout(ncol = 1)
p4[[3]] / DimPlot(Gg.seurat.filtered, label = TRUE, repel = TRUE)

Ap_dimplot <- DimPlot(Ap.seurat.filtered, reduction = 'umap', label = TRUE, repel = TRUE, label.size = 3.5) +NoLegend()
Ap_featureplot <- FeaturePlot(Ap.seurat.filtered, c("LOC101789892", "ITGAE", "ITGA1", "CXCR6"))
Ap_plot <- Ap_dimplot / Ap_featureplot

Cl_dimplot <- DimPlot(Cl.seurat.filtered, reduction = 'umap', label = TRUE, repel = TRUE, label.size = 3.5) +NoLegend()
Cl_featureplot <- FeaturePlot(Cl.seurat.filtered, c("LOC102090584", "ITGAE", "ITGA1"))
Cl_plot <- Cl_dimplot / Cl_featureplot

Gg.controlminus_dimplot <- DimPlot(Gg.seurat.controlminus.integrated, reduction = 'umap', label = TRUE, repel = TRUE, label.size = 3.5) +NoLegend()
Gg.controlminus_featureplot <- FeaturePlot(Gg.seurat.controlminus.integrated, c("CD69L", "ITGA1"))
Gg.controlminus_plot <- Gg.controlminus_dimplot / Gg.controlminus_featureplot

Gg.controlplus_dimplot <- DimPlot(Gg.seurat.controlplus.integrated, reduction = 'umap', label = TRUE, repel = TRUE, label.size = 3.5) +NoLegend()
Gg.controlplus_featureplot <- FeaturePlot(Gg.seurat.controlplus.integrated, c("CD69L", "ITGA1"))
Gg.controlplus_plot <- Gg.controlplus_dimplot / Gg.controlplus_featureplot

Gg.Herts33minus_dimplot <- DimPlot(Gg.seurat.Herts33minus.integrated, reduction = 'umap', label = TRUE, repel = TRUE, label.size = 3.5) +NoLegend()
Gg.Herts33minus_featureplot <- FeaturePlot(Gg.seurat.Herts33minus.integrated, c("CD69L", "ITGA1"))
Gg.Herts33minus_plot <- Gg.Herts33minus_dimplot / Gg.Herts33minus_featureplot

Gg.Herts33plus_dimplot <- DimPlot(Gg.seurat.Herts33plus.integrated, reduction = 'umap', label = TRUE, repel = TRUE, label.size = 3.5) +NoLegend()
Gg.Herts33plus_featureplot <- FeaturePlot(Gg.seurat.Herts33plus.integrated, c("CD69L", "ITGA1"))
Gg.Herts33plus_plot <- Gg.Herts33plus_dimplot / Gg.Herts33plus_featureplot

Gg.LaSotaminus_dimplot <- DimPlot(Gg.seurat.LaSotaminus.integrated, reduction = 'umap', label = TRUE, repel = TRUE, label.size = 3.5) +NoLegend()
Gg.LaSotaminus_featureplot <- FeaturePlot(Gg.seurat.LaSotaminus.integrated, c("CD69L", "ITGA1"))
Gg.LaSotaminus_plot <- Gg.LaSotaminus_dimplot / Gg.LaSotaminus_featureplot

Gg.LaSotaplus_dimplot <- DimPlot(Gg.seurat.LaSotaplus.integrated, reduction = 'umap', label = TRUE, repel = TRUE, label.size = 3.5) +NoLegend()
Gg.LaSotaplus_featureplot <- FeaturePlot(Gg.seurat.LaSotaplus.integrated, c("CD69L", "ITGA1"))
Gg.LaSotaplus_plot <- Gg.LaSotaplus_dimplot / Gg.LaSotaplus_featureplot

##plots
tiff('Ap_Cl.tiff', units="in", width=10, height=10, res=900, compression = 'lzw')
ggarrange(Ap_plot, Cl_plot, ncol = 2, labels = c("A) Ap_plot", "B) Cl_plot"))
dev.off()

tiff('Gg.tiff', units="in", width=16, height=9, res=900, compression = 'lzw')
ggarrange(Gg.controlminus_plot, Gg.controlplus_plot, Gg.Herts33minus_plot, Gg.Herts33plus_plot, Gg.LaSotaminus_plot, Gg.LaSotaplus_plot, ncol = 3, nrow = 2)
dev.off()

