install.packages("ggsignif")
install.packages("coin")
library(survival)
library(coin)
library(ggsignif)
library(tidyverse)
library(ggplot2)
library(ggpubr)
library(corrplot)


##n-terminal
data <- read.table("N-term.pepstat_group.tsv", header = T, sep = "\t")


data_long <- data[2:13] %>%
  pivot_longer(cols = -c(Group), names_to = "Variable", values_to = "Value")

# Plotting
p <- ggplot(data_long, aes(x = Group, y = Value, color = Group)) +
  geom_boxplot() +
  facet_wrap(~Variable, scales = "free_y", ncol = 6) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Show the plot
png("N-terminal_residue_properties.png", units="in", width=10, height=8.1, res=600)
print(p)
dev.off()

## acidic residue
data_long_acidic <- data[12:13] %>%
  pivot_longer(cols = -c(Group), names_to = "Variable", values_to = "Value")



p_acidic <-ggplot(data_long_acidic, aes(x = Group, y = Value, color = Group)) +
  geom_boxplot() +
  theme(legend.position = "none")+                                        
  geom_signif(comparisons = list( c("Lepidosauria", "Mammals"), c("Testudines", "Mammals"), c("Amphibia", "Mammals") ),
                map_signif_level = TRUE, y_position = c(13, 12, 15)) +
    geom_signif(comparisons = list( c("Aves", "Mammals")),
                map_signif_level = TRUE, y_position = c(14), size =2 , textsize = 5)

png("N-terminal_acidic_residue_properties.png", units="in", width=5.5, height=4.77, res=600)
print(p_acidic)
dev.off()
p_acidic_KW <-ggplot(data_long_acidic, aes(x = Group, y = Value, fill = Group)) +
  geom_boxplot() +
  labs(x = "Groups",
       y = "# acidic amino acid residues")+
  stat_compare_means(label = "p.signif",hide.ns = TRUE, ref.group = ".all.", label.y =15)+
  stat_compare_means(label.y = 16.5)+
  theme_classic()+
  theme(legend.position = "none")
png("N-terminal_acidic_KW_residue_properties.png", units="in", width=4.58, height=4.49, res=600)
print(p_acidic_KW)
dev.off()

#Test for normality
shapiro.test(data_long_acidic$Value)
qqnorm(data_long_acidic$Value)
qqline(data_long_acidic$Value)
hist(data_long_acidic$Value, breaks = 20, col = "skyblue", main = "Histogram")

# Perform Kruskal-Wallis test to check for overall group differences
kruskal.test(Value ~ Group, data = data_long_acidic)
# Convert p_values to a long format
library(tidyr)
p_values_long <- as.data.frame(as.table(p))
names(p_values_long) <- c("group1", "group2", "p")
p_values_long$p.adj<-p.adjust(p_values_long$p, method = "BH")
p_values_long <- na.omit(p_values_long)
p_values_long$y.position <- y.position$y.position
boxplot1_p_adj_PW<- ggboxplot(data_long_acidic, x = "Group", y = "Value", fill = "Group")+ stat_pvalue_manual(p_values_long, label = "p.adj", tip.length = 0.01)+
  labs(x = "Groups",
       y = "# acidic amino acid residues")+
  theme_classic()+
  theme(legend.position = "none")
##pairwise comparison
getwd()
library(ggpubr)
library(rstatix)
boxplot <- ggboxplot(data_long_acidic, x = "Group", y = "Value", fill = "Group")
stat.test <- data_long_acidic %>% wilcox_test(Value ~ Group, p.adjust.method = "BH", paired = FALSE)
y.position <-stat.test %>%add_xy_position(x = "Group")
stat.test$y.position <- y.position$y.position
boxplot1_p_adj<- boxplot+ stat_pvalue_manual(stat.test, label = "p.adj", tip.length = 0.01)+
  labs(x = "Groups",
       y = "# acidic amino acid residues")+
  theme_classic()+
  theme(legend.position = "none")
png("N-terminal_acidic_residue_properties_pairwise_p_adj.png", units="in", width=4.58, height=4.49, res=600)
print(boxplot1_p_adj)
dev.off()
boxplot1_p_adj_sig<- boxplot+ stat_pvalue_manual(stat.test, label = "p.adj.signif", tip.length = 0.01)+
  labs(x = "Groups",
       y = "# acidic amino acid residues")+
  theme_classic()+
  theme(legend.position = "none")
png("N-terminal_acidic_residue_properties_pairwise_p_adj_sig.png", units="in", width=4.58, height=4.49, res=600)
print(boxplot1_p_adj_sig)
dev.off()
wilcox_test_result <- pairwise.wilcox.test( x = data_long_acidic$Value, g = data_long_acidic$Group, p.adjust.method = "BH", paired = FALSE)

##c-termial
setwd("../C-term_splitfa/")
data <- read.table("C-term.pepstat_group.tsv", header = T, sep = "\t")


data_long <- data[2:13] %>%
  pivot_longer(cols = -c(Group), names_to = "Variable", values_to = "Value")

# Plotting
p <- ggplot(data_long, aes(x = Group, y = Value, color = Group)) +
  geom_boxplot() +
  facet_wrap(~Variable, scales = "free_y", ncol = 6) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Show the plot
png("C-terminal_residue_properties.png", units="in", width=10, height=8.1, res=600)
print(p)
dev.off()

## acidic residue
data_long_acidic <- data[12:13] %>%
  pivot_longer(cols = -c(Group), names_to = "Variable", values_to = "Value")
meancomparisons = list( c("Aves", "Mammals"), c("Lepidosauria", "Mammals"), c("Testudines", "Mammals"), c("Amphibia", "Mammals") )

p_acidic <- ggplot(data_long_acidic, aes(x = Group, y = Value, color = Group)) +
  geom_boxplot() +
  facet_wrap(~Variable, scales = "free_y", ncol = 5) +
  theme(legend.position = "bottom")+ 
  stat_compare_means(comparisons = meancomparisons, label.y = c(14, 13, 12, 15))+
  stat_compare_means(label.y = 17)
png("N-terminal_acidic_residue_properties.png", units="in", width=10, height=8.1, res=600)
print(p_acidic)
dev.off()