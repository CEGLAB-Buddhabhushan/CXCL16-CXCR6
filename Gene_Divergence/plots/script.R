setwd("/home/ceglab358/BUDDHA/GITHUB_CXCR6_CXCL16/CXCR6_CXCL16/Gene_Divergence/plots/")
library(ggplot2)
library(gridExtra)
library(patchwork)
file_list <- list.files(pattern = "_wrt_chicken.tsv")
data_list <- list()
for (file in file_list) {
  data <- read.table(file, header = TRUE, sep = "\t")
  data_list[[file]] <- data
}
combined_data <- do.call(rbind, data_list)


CXCR6_df <- read.table("Birds_CXCR6_identity_wrt_mallard.sorted.tsv", header = T, sep = '\t')
LAT_df <- read.table("Birds_LAT_identity_wrt_chicken.tsv", header = T, sep = '\t')
TNFa_df <- read.table("Birds_TNFa_identity_wrt_chicken.tsv", header = T, sep = '\t')
Gene_merge <- rbind(LAT_df, TNFa_df)
p1 <-ggplot(combined_data, aes(x=Species, y=Per_identity, fill=Species)) + 
  geom_violin() +
  geom_boxplot(width = 0.2, fill = "white", color = "black") +
  labs(y = "% Identity", title = "wrt Chicken") +
  theme_minimal()+
  coord_flip(ylim = c(20, 100))
p2 <-ggplot(CXCR6_df, aes(x = Species, y = Per_identity, fill=Species)) +
  geom_violin() +
  geom_boxplot(width = 0.2, fill = "white", color = "black") +
  labs(y = "% Identity", title = "Mallard CXCR6 Gene Identity Across Birds") +
  theme_minimal()+
  coord_flip(ylim = c(20, 100))
p3 <-ggplot(Gene_merge, aes(x = Gene, y = ident, fill=Gene)) +
  geom_violin() +
  geom_point(aes(color = species), size = 3) +
  geom_boxplot(width = 0.2, fill = "white", color = "black") +
  labs(y = "Identity Score", title = "TNFa and LAT Gene  % Identity") +
  theme_minimal()+
  coord_flip(ylim = c(20, 100))+
  theme(legend.position = "right")
png('wrt_chicken.png', units="in", width=16, height=9, res=600)
p1
dev.off()
png('Birds_CXCR6_identity_wrt_mallard.png', units="in", width=16, height=2, res=600)
p2
dev.off()
png('LAT_and_TNFa_wrt_chicken.png', units="in", width=16, height=6, res=600)
p3
dev.off()
png('All.png', units="in", width=16, height=9, res=600)
p1 / p2 /p3
dev.off()
