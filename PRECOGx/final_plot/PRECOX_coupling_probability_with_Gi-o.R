setwd("/home/ceglab358/BUDDHA/GITHUB_CXCR6_CXCL16/CXCR6_CXCL16/PRECOGx/final_plot/")
library(ggplot2)
library(tidyverse)
library(ggpubr)
df <- read.table("PRECOX_coupling_probability_with_Gi-o.tsv", sep = '\t', header = T)
data_long <- tidyr::pivot_longer(df, cols = -(1:2), names_to = "Variable", values_to = "Value")
colors <- c("GoA" = "#FF204E","GoB"= "#387ADF", "GNAI1" = "#FDA403", "GNAI2" ="#2D9596", "GNAI3"="#535C91", "GNAZ" ="#EFF396")
png('PRECOGx_Gi-o.png', units="in", width=12.5, height=9, res=600)
ggplot(data_long, aes(x = Group, y = Value, fill = Variable)) +
  geom_boxplot() +
  geom_hline(yintercept = 0.75,linetype = "dashed") +
  labs(x = "Groups", y = "G-protein Coupling probability Value") +
  scale_fill_manual(values = colors)+
  coord_flip()
dev.off()

#####sorted GoA-GoB

df_Go <- df_long[df_long$variable %in% c("GoA", "GoB"), ]
Go_colors <- c("GoA" = "#FF204E","GoB"= "#387ADF")
png('PRECOGx_Go.png', units="in", width=16, height=9, res=600)
ggplot(df_Go, aes(x = Group, y = value, fill = variable)) +
  geom_boxplot() +
  geom_hline(yintercept = 0.75,linetype = "dashed") +
  labs(x = "Groups", y = "G-protein Coupling probability Value") +
  scale_fill_manual(values = Go_colors)+
  coord_flip() 
dev.off()

