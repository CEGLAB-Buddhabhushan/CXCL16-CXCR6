library(ggpubr)
library(dplyr)
library(ggplot2)

df<- read.table("CXCL16_GC_content-GC_Stretch.tsv", header =T, sep = '\t')
chicken_df<- read.table("../chicken_ref/Chicken_GC_content-GC_Stretch.tsv", header = T, sep = '\t')
chicken_df <- cbind(Group = "Chicken", chicken_df)
names(chicken_df) <- c("Group", "Species_name", "GC_content", "GC_Stretch")
merge_df<- rbind(df, chicken_df)

Group <- c("Amphibia", "Aves", "Squamata", "Testudines", "Afrotheria",
           "Artiodactyla", "Carnivora", "Chiroptera", "Eulipotyphla",
           "Lagomorpha", "Metatheria_Monotremata", "Perissodactyla",
           "Pholidota", "Primates", "Rodentia", "Xenarthra")
colors <- c("#ff7f00",  "#e31a1c","#33a02c", "#0000FF", "#FFD700",
            "#F0E68C", "#D8BFD8", "#b2df8a", "#fb9a99", "#fdbf6f",
            "#cab2d6", "#6b486b", "#ffff99", "#8c510a", "#613091", "#D2B48C")
shapes <- c(19, 17, 18, 15, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11)

color_mapping <- setNames(colors, Group)
shape_mapping <- setNames(shapes, Group)


p1 <- ggplot() +
  geom_point(data = merge_df[241:41126, ], aes(x = GC_Stretch, y = GC_content),alpha = 0.02, color = "gray")+
  geom_point(data = merge_df[1:240, ], aes(x = GC_Stretch, y = GC_content, color = Group, shape = Group), size = 3) +
  scale_color_manual(values = color_mapping, name = "Group") +
  scale_shape_manual(values = shape_mapping, name = "Group") +
  labs(title = "CXCR16 GC-content vs G/C-stretch length",
       x = "Average length of G/C-stretches",
       y = "GC content (in %)") +
  guides(color = guide_legend(ncol = 1, byrow = TRUE)) +
  theme_classic()+
  theme(legend.position = "bottom", plot.title = element_blank(),
        axis.text = element_text(face = "bold"),
        axis.title = element_text(face = "bold"))+
  guides(color = guide_legend(ncol = 4, byrow = FALSE))

png("CXCL16_GC_content-GC_Stretch_lp-b.png", units="in", width=16, height=9, res=600)
print(p1)
dev.off()
