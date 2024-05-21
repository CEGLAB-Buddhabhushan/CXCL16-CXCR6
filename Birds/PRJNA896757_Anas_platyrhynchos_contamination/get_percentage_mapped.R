setwd("~/BUDDHA/GITHUB_CXCR6_CXCL16/CXCR6_CXCL16/Birds/PRJNA896757_Anas_platyrhynchos_contamination")
library(ggplot2)
library(tidyr)

data <- read.table("PRJNA896757_Anas_platyrhynchos_contamination.tsv", sep = '\t', header = T)
data_long <- gather(data, key = "Percentage_Type", value = "Percentage", -SRR_Acc)
png('Anas_platyrhynchos_contamination.png', units="in", width=15, height=8.5, res=600)
ggplot(data_long, aes(x = reorder(SRR_Acc, Percentage), y = Percentage, fill = Percentage_Type)) +
  geom_bar(stat = "identity") +
  labs(title = "Percentage of Anas platyrhynchos reads mapped to Homo sapiens for each sample",
       x = "SRA Accession IDs", y = "Percentage of reads mapped") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_manual(values = c("Hspercentage" = "#ff0065", "Appercentage" = "skyblue")) +
  theme_minimal()+ coord_flip()
dev.off()

bh <- read.table("Homo_sapiens_CXCL16_Exons_blast_hits.tsv", sep = '\t', header = T)
ggplot(bh, aes(x = reorder(SRR_Acc, read_count), y = read_count, fill = Exon)) +
  geom_bar(stat = "identity") +
  labs(title = "Percentage of Anas platyrhynchos reads mapped to Homo sapiens for each sample",
       x = "SRA Accession IDs", y = "Percentage of reads mapped") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme_minimal()+ coord_flip()
