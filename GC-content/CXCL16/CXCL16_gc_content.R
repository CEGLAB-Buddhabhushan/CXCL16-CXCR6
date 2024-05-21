library(ggpubr)
library(dplyr)
library(ggplot2)
df<- read.table("GC_content.tsv", header =T, sep = '\t')
Group <- c("Amphibia", "Aves", "Squamata", "Testudines", "Afrotheria",
           "Artiodactyla", "Carnivora", "Chiroptera", "Eulipotyphla",
           "Lagomorpha", "Metatheria_Monotremata", "Perissodactyla",
           "Pholidota", "Primates", "Rodentia", "Xenarthra")
fill <- c("#1f78b4", "#33a02c", "#e31a1c", "#ff7f00", "#6a3d9a",
            "#b15928", "#a6cee3", "#b2df8a", "#fb9a99", "#fdbf6f",
            "#cab2d6", "#6b486b", "#ffff99", "#8c510a", "#613091", "#8c510a")
fill_mapping <- setNames(fill, Group)
p1<- ggplot(df, aes(x = Group, y = GC, fill = Group)) +
  geom_boxplot() +
  scale_fill_manual(values = fill_mapping, name = "Group") +
  stat_summary(fun = "median", geom = "text", aes(label = paste(round(..y.., 2))), vjust = -0.5, position = position_dodge(width = 0.75), size = 4)+
  labs(title = "CXCL16 GC-Content by Group", x = "Groups", y = "GC Content (in %)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none") +
  geom_hline(yintercept = 50, linetype = "dashed", color = "red", lwd = 1.5) +
  scale_y_continuous(limits = c(30, 80))


png("CXCL16_GC_content.png", units="in", width=16, height=9, res=600)
print(p1)
dev.off()
