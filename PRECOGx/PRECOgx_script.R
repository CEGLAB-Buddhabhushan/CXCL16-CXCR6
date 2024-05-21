setwd("/home/ceglab358/BUDDHA/GITHUB_CXCR6_CXCL16/CXCR6_CXCL16/PRECOGx/")

library(ggpubr)
library(dplyr)
library(ggplot2)
df<- read.table("All_INPUTs_precogx_output.tsv", sep = "\t", header = T)

df_long <- reshape2::melt(df, id.vars = c("Species_name", "Group"))
###G -protein
#Gs:GNAS	GNAL
#Gi/o:GNAI1	GNAI2	GNAI3	GoA	GoB	GNAZ
#Gq:/G11:GNA11	GNA14	GNA15	GNAQ
#G12/13:GNA12	GNA13
#β-arrs:β-arr1-GRK2	β-arr2	β-arr2-GRK2
df_long$Species_name <- factor(df_long$Species_name, levels = unique(df_long$Species_name[order(df_long$Group)]))


# Reorder levels of "Group" variable
df_long$Group <- factor(df_long$Group, levels = c("Amphibia", "Aves", "Sphenodon_punctatus", "Squamata", "Testudines", "Monotremata", "Metatheria", "Afrotheria", "Artiodactyla", "Carnivora", "Chiroptera", "Eulipotyphla", "Lagomorpha", "Perissodactyla", "Pholidota", "Primates", "Rodentia", "Xenarthra"))

# Your existing code for summarizing species count and merging
df_species_count <- df_long %>%
  group_by(Group) %>%
  summarise(species_count = n_distinct(Species_name))

df_long <- df_long %>%
  left_join(df_species_count, by = "Group")


ggplot(df_long, aes(x = Species_name, y = value)) +
  geom_point(aes(shape = factor(Group))) +
  scale_fill_manual(values = c(custom_colors, "gray")) +
  facet_wrap(~ variable, scales = "fixed", strip.position = "top") +
  labs(title = "PRECOGx-predicted coupling probabilities of CXCR6",
       x = "Group",
       y = "PRECOGx Value",
       fill = "Group") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  geom_hline(yintercept = 0.5, linetype = "dashed", color = "red") +
  # Add species count in legends
  guides(fill = guide_legend(title = "Group (Number of Species)")) +
  scale_fill_discrete(labels = function(x) paste0(x, " (", df_species_count$species_count, ")"))


# Assuming 'group_colors' is a vector of colors
# Specify colors for specific groups (Amphibia, Aves, Sphenodon_punctatus, Squamata, Testudines, and Primates)
custom_colors <- c(Amphibia = "cyan", Aves = "red", Sphenodon_punctatus = "green", Squamata = "purple", Testudines = "orange", Primates = "blue")

# Assuming 'group_shapes' is a vector of shapes
# Specify shapes for specific groups (Amphibia, Aves, Sphenodon_punctatus, Squamata, Testudines, and Primates)
custom_shapes <- c(Amphibia = 16, Aves = 17, Sphenodon_punctatus = 18, Squamata = 19, Testudines = 20, Primates = 15)

ggplot(df_long, aes(x = Species_name, y = value, fill = Group)) +
  geom_point(size = 2, shape = 18, aes(shape = factor(Group))) +
  facet_wrap(~ variable, scales = "fixed", strip.position = "top") +
  labs(title = "PRECOGx-predicted coupling probabilities of CXCR6",
       x = "Group",
       y = "PRECOGx Value",
       fill = "Group") +
  theme(axis.title.x=element_blank(),axis.text.x=element_blank(),axis.ticks.x=element_blank()) +
  geom_hline(yintercept = 0.5, linetype = "dashed", color = "red") +
  # Add species count in legends
  guides(fill = guide_legend(title = "Group (Number of Species)"))+
  scale_fill_discrete(labels = function(x) paste0(x, " (", df_species_count$species_count, ")"))



Groups <- c("Amphibia", "Aves", "Sphenodon_punctatus", "Squamata", "Testudines", "Monotremata", "Metatheria", "Afrotheria", "Artiodactyla", "Carnivora", "Chiroptera", "Eulipotyphla", "Lagomorpha", "Perissodactyla", "Pholidota", "Primates", "Rodentia", "Xenarthra")

custom_colors <- setNames(hcl(seq(15, 375, length.out = length(Groups) + 1)[1:length(Groups)], 100, 70), Groups)

# Generate custom shapes for all groups
custom_shapes <- setNames(seq(15, 15 + length(Groups) - 1), Groups)

# Your ggplot code
ggplot(df_long, aes(x = Species_name, y = value, fill = factor(Group))) +
  geom_point(size = 4, shape = 21, stroke = 0, aes(shape = factor(Group))) +
  scale_fill_manual(values = c(custom_colors, "gray")) +
  scale_shape_manual(values = c(custom_shapes, 1)) +
  facet_wrap(~ variable, scales = "fixed", strip.position = "top") +
  labs(title = "PRECOGx-predicted coupling probabilities of CXCR6",
       x = "Group",
       y = "PRECOGx Value",
       fill = "Group") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  geom_hline(yintercept = 0.5, linetype = "dashed", color = "red") +
  # Add species count in legends
  guides(fill = guide_legend(title = "Group (Number of Species)"))
#Gs:GNAS	GNAL
df_Gs <- df_long[df_long$variable %in% c("GNAS", "GNAL"), ]

pGs <- ggplot(df_Gs, aes(x = Species_name, y = value, fill = Group)) +
  geom_bar(stat = "identity", position = position_dodge(width = NULL)) +
  facet_wrap(~ variable, scales = "fixed", strip.position = "top", ncol = 2) +
  labs(title = "PRECOG-predicted coupling probabilities of CXCR6 to Gs",
       x = "Variant",
       y = "PRECOGx Value",
       fill = "Group") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),legend.position = "right") +
  coord_cartesian(ylim = c(0, 1)) +
  geom_hline(yintercept = 0.5, linetype = "dashed", color = "red")
  

#Gi/o:GNAI1	GNAI2	GNAI3	GoA	GoB	GNAZ
df_Gi <- df_long[df_long$variable %in% c("GNAI1", "GNAI2", "GNAI3", "GoA", "GoB", "GNAZ"), ]

pGi <- ggplot(df_Gi, aes(x = Species_name, y = value, fill = Variant)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.8)) +
  facet_wrap(~ variable, scales = "fixed", strip.position = "top", ncol = 6) +
  labs(title = "PRECOG-predicted coupling probabilities of CXCR6 to Gi/o",
       x = "Variant",
       y = "PRECOGx Value",
       fill = "Variant") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),legend.position = "right") +
  coord_cartesian(ylim = c(0, 1)) +
  geom_hline(yintercept = 0.5, linetype = "dashed", color = "red")

#Gq/G11:GNA11	GNA14	GNA15	GNAQ
df_Gq <- df_long[df_long$variable %in% c("GNA11", "GNA14", "GNA15", "GNAQ"), ]

pGq <- ggplot(df_Gq, aes(x = Species_name, y = value, fill = Variant)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.8)) +
  facet_wrap(~ variable, scales = "fixed", strip.position = "top", ncol = 4) +
  labs(title = "PRECOG-predicted coupling probabilities of CXCR6 to Gq/G11",
       x = "Variant",
       y = "PRECOGx Value",
       fill = "Variant") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),legend.position = "right") +
  coord_cartesian(ylim = c(0, 1)) +
  geom_hline(yintercept = 0.5, linetype = "dashed", color = "red")

#G12/13:GNA12	GNA13
df_G12_13 <- df_long[df_long$variable %in% c("GNA12", "GNA13"), ]

pG12_13 <- ggplot(df_G12_13, aes(x = Species_name, y = value, fill = Variant)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.8)) +
  facet_wrap(~ variable, scales = "fixed", strip.position = "top", ncol = 2) +
  labs(title = "PRECOG-predicted coupling probabilities of CXCR6 to G12/13",
       x = "Variant",
       y = "PRECOGx Value",
       fill = "Variant") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),legend.position = "right") +
  coord_cartesian(ylim = c(0, 1)) +
  geom_hline(yintercept = 0.5, linetype = "dashed", color = "red")

#β-arrs:β-arr1-GRK2	β-arr2	β-arr2-GRK2
df_B <- df_long[df_long$variable %in% c("Barr1.GRK2", "Barr2", "Barr2.GRK2"), ]

pB <- ggplot(df_B , aes(x = Species_name, y = value, fill = Variant)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.8)) +
  facet_wrap(~ variable, scales = "fixed", strip.position = "top", ncol = 3) +
  labs(title = "PRECOG-predicted coupling probabilities of CXCR6 to β-arrs",
       x = "Variant",
       y = "PRECOGx Value",
       fill = "Variant") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),legend.position = "right") +
  coord_cartesian(ylim = c(0, 1)) +
  geom_hline(yintercept = 0.5, linetype = "dashed", color = "red")

ggsave("Aves-Primates_Gs.png", plot = pGs, width = 10, height = 5, dpi = 1200)
ggsave("Aves-Primates_Gq.png", plot = pGq, width = 20, height = 5, dpi = 1200)
ggsave("Aves-Primates_Gi.png", plot = pGi, width = 25, height = 5, dpi = 1200)
ggsave("Aves-Primates_G12_13.png", plot = pG12_13, width = 10, height = 5, dpi = 1200)
ggsave("Aves-Primates_β-arrs.png", plot = pB, width = 15, height = 5, dpi = 1200)
