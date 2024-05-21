setwd("/home/ceglab358/BUDDHA/GITHUB_CXCR6_CXCL16/CXCR6_CXCL16/GC-content/")
library(ggpubr)
library(dplyr)
library(ggplot2)

chicken_df<- read.table("chicken_ref/Chicken_GC_content-GC_Stretch.tsv", header = T, sep = '\t')
chicken_df <- cbind(Group = "Chicken", chicken_df)
names(chicken_df) <- c("Group", "Species_name", "GC_content", "GC_Stretch")
CXCL16_df<- read.table("CXCL16/CXCL16_GC_content-GC_Stretch.tsv", header =T, sep = '\t')
CXCL16_merge_df<- rbind(CXCL16_df, chicken_df)
CXCR6_df<- read.table("CXCR6/CXCR6_GC_content-GC_Stretch.tsv", header =T, sep = '\t')
CXCR6_merge_df<- rbind(CXCR6_df, chicken_df)
CXCL16_gc_df<- read.table("CXCL16/GC_content.tsv", header =T, sep = '\t')
CXCR6_gc_df<- read.table("CXCR6/GC_content.tsv", header =T, sep = '\t')

Group <- c("Amphibia", "Aves", "Squamata", "Testudines", "Afrotheria",
           "Artiodactyla", "Carnivora", "Chiroptera", "Eulipotyphla",
           "Lagomorpha", "Metatheria_Monotremata", "Perissodactyla",
           "Pholidota", "Primates", "Rodentia", "Xenarthra")
colors <- c("#ff7f00",  "#e31a1c","#33a02c", "#0000FF", "#FFD700",
            "#F0E68C", "#800080", "#b2df8a", "#fb9a99", "#fdbf6f",
            "#cab2d6", "#6b486b", "#ffff99", "#8c510a", "#613091", "#D2B48C")
shapes <- c(19, 17, 18, 15, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11)

color_mapping <- setNames(colors, Group)
shape_mapping <- setNames(shapes, Group)
fill_mapping <- setNames(colors, Group)


CXCL16_plot <- ggplot() +
  geom_point(data = CXCL16_merge_df[233:41126, ], aes(x = GC_Stretch, y = GC_content),alpha = 0.02, color = "gray")+
  geom_point(data = CXCL16_merge_df[1:232, ], aes(x = GC_Stretch, y = GC_content, color = Group, shape = Group), size = 3) +
  scale_color_manual(values = color_mapping, name = "Group") +
  scale_shape_manual(values = shape_mapping, name = "Group") +
  labs(title = "CXCL16 GC-content vs Avg. G/C-stretch length",
       x = "Average length of G/C-stretches",
       y = "GC content (in %)") +
  theme_classic()+
  scale_y_continuous(limits = c(30, 80))+
  scale_x_continuous(limits = c(2.7, 7)) +
  theme(legend.position = "bottom", legend.box = "horizontal",
        axis.text = element_text(face = "bold"))+
  guides(color = guide_legend(nrow = 2, byrow = TRUE, title = NULL),
    shape = guide_legend(nrow = 2, byrow = TRUE, title = NULL))

CXCR6_plot <- ggplot() +
  geom_point(data = CXCR6_merge_df[350:41243, ], aes(x = GC_Stretch, y = GC_content),alpha = 0.02, color = "gray")+
  geom_point(data = CXCR6_merge_df[1:349, ], aes(x = GC_Stretch, y = GC_content, color = Group, shape = Group), size = 3) +
  scale_color_manual(values = color_mapping, name = "Group") +
  scale_shape_manual(values = shape_mapping, name = "Group") +
  labs(title = "CXCR6 GC-content vs Avg. G/C-stretch length",
       x = "Average length of G/C-stretches",
       y = "GC content (in %)") +
  theme_classic()+
  scale_y_continuous(limits = c(30, 80))+
  scale_x_continuous(limits = c(2.7, 7)) +
  theme(legend.position = "bottom", legend.box = "horizontal",
        axis.text = element_text(face = "bold"))+
  guides(color = guide_legend(nrow = 2, byrow = TRUE, title = NULL),
         shape = guide_legend(nrow = 2, byrow = TRUE, title = NULL))


CXCL16_gc_plot<- ggplot(CXCL16_gc_df, aes(x = Group, y = GC, fill = Group)) +
  geom_boxplot() +
  scale_fill_manual(values = fill_mapping, name = "Group") +
  stat_summary(fun = "median", geom = "text", aes(label = paste(round(..y.., 2))), vjust = -0.5, position = position_dodge(width = 0.75), size = 4)+
  labs(title = "CXCL16 GC-Content by Group", x = "Groups", y = "GC content (in %)") +
  annotate("rect", xmin = -Inf, xmax = +Inf, ymin = 50, ymax = 60, alpha = 0.1,fill = "green")+ 
  annotate("rect", xmin = -Inf, xmax = +Inf, ymin = 30, ymax = 40, alpha = 0.1,fill = "red")+ 
  annotate("rect", xmin = -Inf, xmax = +Inf, ymin = 70, ymax = 80, alpha = 0.1,fill = "red")+
  scale_y_continuous(limits = c(30, 80))+
  theme_classic()+
  scale_x_discrete(guide = guide_axis(n.dodge = 2))+
  theme(legend.position = "bottom", legend.box = "horizontal",
        axis.text = element_text(face = "bold"), text = element_text(size=9))+
  guides(fill=guide_legend(nrow=2,byrow=TRUE, title = NULL))
CXCR6_gc_plot<- ggplot(CXCR6_gc_df, aes(x = Group, y = GC, fill = Group)) +
  geom_boxplot() +
  scale_fill_manual(values = fill_mapping, name = "Group") +
  stat_summary(fun = "median", geom = "text", aes(label = paste(round(..y.., 2))), vjust = -0.5, position = position_dodge(width = 0.75), size = 4)+
  labs(title = "CXCR6 GC-Content by Group", x = "Groups", y = "GC content (in %)") +
  annotate("rect", xmin = -Inf, xmax = +Inf, ymin = 50, ymax = 60, alpha = 0.1,fill = "green")+ 
  annotate("rect", xmin = -Inf, xmax = +Inf, ymin = 30, ymax = 40, alpha = 0.1,fill = "red")+ 
  annotate("rect", xmin = -Inf, xmax = +Inf, ymin = 70, ymax = 80, alpha = 0.1,fill = "red")+  scale_y_continuous(limits = c(30, 80))+
  theme_classic() +
  scale_x_discrete(guide = guide_axis(n.dodge = 2))+
  theme(legend.position = "bottom", legend.box = "horizontal",
        axis.text = element_text(face = "bold"), text = element_text(size=9))+
  guides(fill=guide_legend(nrow=2,byrow=TRUE, title = NULL))



p1<-ggarrange(CXCL16_gc_plot, CXCR6_gc_plot, ncol = 1, nrow = 2, labels = c("A", "C"), common.legend = TRUE, legend = "bottom", align = "hv")+
  guides(fill=guide_legend(nrow=2,byrow=TRUE, title = NULL))
p2<-ggarrange(  CXCL16_plot, CXCR6_plot,ncol = 1, nrow = 2, labels = c("B", "D"), common.legend = TRUE, legend = "bottom", align = "hv")+
  guides(fill=guide_legend(nrow=2,byrow=TRUE, title = NULL))

combined_plot<-ggarrange(p1, p2, ncol = 2, nrow = 1, common.legend = TRUE, legend = "bottom", align = "hv",widths=c(0.85,1))+
  guides(fill=guide_legend(nrow=2,byrow=TRUE, title = NULL))


png("CXCL16-CXCR6-GC-content.png", units="in", width=18, height=9, res=900)
print(combined_plot)
dev.off()
