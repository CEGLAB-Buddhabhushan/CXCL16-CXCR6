library(ggplot2)
library(gridExtra)
library(patchwork)

setwd("/home/ceglab358/BUDDHA/GITHUB_CXCR6_CXCL16/CXCL16-CXCR6/newly_added/CXCL16_revision/Final/sequence_divergence/Gene_Divergence/plots/")

# Load datasets
CXCR6_df <- read.table("Birds_CXCR6_identity_wrt_mallard.sorted.tsv", header = TRUE, sep = '\t')
LAT_df <- read.table("Birds_LAT_identity_wrt_chicken.tsv", header = TRUE, sep = '\t')
TNFa_df <- read.table("Birds_TNFa_identity_wrt_chicken.tsv", header = TRUE, sep = '\t')
CXCL16_df <- read.table("Birds_and_other_CXCL16_identity_wrt_Phalacrocorax_carbo.tsv", header = TRUE, sep = '\t')
CXCR6_df$Gene <- "CXCR6"
LAT_df$Gene <- "LAT"
TNFa_df$Gene <- "TNFa"
CXCL16_df$Gene <- "CXCL16"

# Merge the datasets into one data frame
Gene_merge <- rbind(CXCR6_df, LAT_df, TNFa_df, CXCL16_df)

# Create the combined violin plot
p3 <- ggplot(Gene_merge, aes(x = Gene, y = ident, fill = Gene)) +
  geom_violin() +  # Violin plot
  geom_point(aes(), size = 2) +  # Points representing species
  geom_boxplot(width = 0.1, fill = "white", color = "black") +  # Boxplot overlaid
  labs(y = "Identity Score", title = "Gene % Identity Across Species") +  # Labels
  theme_minimal() +  # Minimal theme
  coord_flip(ylim = c(20, 100)) +  # Flip coordinates and set y-axis limits
  theme(legend.position = "right")  # Place legend on the right

# Show the plot
print(p3)

png('Gene_sequence_divergence.png', units="in", width=16, height=9, res=900)
p3
dev.off()
