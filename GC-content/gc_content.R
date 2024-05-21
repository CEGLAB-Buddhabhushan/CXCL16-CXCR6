library(ggpubr)
library(dplyr)
library(ggplot2)

df<- read.table("GC_content.tsv", header =T, sep = '\t')

p1<- ggplot(df, aes(x = Group, y = GC)) +
  geom_boxplot() +
  stat_summary(fun = "median", geom = "text", aes(label = paste(round(..y.., 2))), vjust = -0.5, position = position_dodge(width = 0.75), size = 4)+
  labs(title = "GC-Content by Group", x = "Groups", y = "GC %") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none") +
  geom_hline(yintercept = 50, linetype = "dashed", color = "red", lwd = 1.5)


png("GC_content.png", units="in", width=16, height=9, res=600)
print(p1)
dev.off()
