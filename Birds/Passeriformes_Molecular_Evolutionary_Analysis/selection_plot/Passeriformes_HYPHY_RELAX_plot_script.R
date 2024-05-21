library(ggplot2)

df <-read.table("Passeriformes_HYPHY_RELAX.Results.txt", header = T, sep = '\t')
df$adjusted_p_value <- p.adjust(df$pval, method = "fdr")
write.table(df, file='Passeriformes_HYPHY_RELAX.Results_p.adj.tsv', quote=T, sep='\t', col.names = NA)


species_names <- c("Acanthisitta_chloris", "Aquila_chrysaetos", "Colius_striatus", "Falco_peregrinus", "Falco_tinnunculus", "Haliaeetus_leucocephalus", "Leptosomus_discolor", "Tyto_alba", "Camarhynchus_parvulus", "Chloebia_gouldiae", "Coloeus_monedula", "Corvus_brachyrhynchos", "Corvus_moneduloides", "Ficedula_albicollis", "Geospiza_fortis", "Lonchura_striata","Malurus_cyaneus","Manacus_vitellinus", "Oriolus_oriolus", "Parus_major", "Passer_domesticus", "Serinus_canaria", "Taeniopygia_guttata", "Zonotrichia_albicollis")
colors <- c("#40FF00", "#FF4000", "#FF8000", "#FFBF00", "#FFFF00", "#BFFF00" , "#80FF00","#FF0000","#00FF00", "#00FF40","#00FF80","#00FFBF", "#00FFFF","#00BFFF","#0080FF", "#0040FF","#0000FF","#4000FF", "#8000FF","#BF00FF","#FF00FF", "#FF00BF","#FF0080","#FF0040")  
shapes <- c(17, 13, 3, 4, 4, 10, 7, 8, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17)
color_mapping <- setNames(colors, species_names)
shape_mapping <- setNames(shapes, species_names)
plot <-ggplot(df, aes(x = kval, y = adjusted_p_value, color = foreground_species, shape = foreground_species)) +
  geom_point(size = 4) +
  scale_color_manual(values = color_mapping) +
  scale_shape_manual(values = shape_mapping) +
  labs(title = "PASSERIFORMES RELAX SELECTION",
       x = "Relaxation/intensification parameter (k)",
       y = "P value",
       color = "Foreground Species",
       shape = "Foreground Species") +
  geom_hline(yintercept = 0.05, linetype = "dashed", color = "red") +
  geom_vline(xintercept = 1, linetype = "dashed", color = "blue") + 
  annotate("text", x = 1.105, y = 0.05, label = "pval = 0.05", color = "red", vjust = -1) + 
  annotate("text", x = 1.105, y = 0.07, label = "k = 1", color = "blue", vjust = -1) +
  theme(legend.position = "right", plot.title = element_blank()) +
  guides(color = guide_legend(ncol = 1, byrow = TRUE))+
  theme_classic()

png("Passeriformes_HYPHY_RELAX_plot.png", units="in", width=10, height=8.1, res=600)
print(plot)
dev.off()
pdf("Passeriformes_HYPHY_RELAX_plot.pdf")
print(plot)
dev.off()
