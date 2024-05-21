hyphy<- read.table("HYPHY_Results.tsv", sep = "\t", header  = T)
df <- data.frame(hyphy)
Afrotheria_df<- df[df$Group=="Afrotheria",]
Afrotheria_df$RELAX_adj.pval <- p.adjust(Afrotheria_df$RELAX_pval, method = "fdr")
write.table(Afrotheria_df, file='Afrotheria.HYPHY.tsv', quote=T, sep='\t', col.names = NA)
Amphibia_df<- df[df$Group=="Amphibia",]
Amphibia_df$RELAX_adj.pval <- p.adjust(Amphibia_df$RELAX_pval, method = "fdr")
write.table(Amphibia_df, file='Amphibia.HYPHY.tsv', quote=T, sep='\t', col.names = NA)
Artiodactyla_df<- df[df$Group=="Artiodactyla",]
Artiodactyla_df$RELAX_adj.pval <- p.adjust(Artiodactyla_df$RELAX_pval, method = "fdr")
write.table(Artiodactyla_df, file='Artiodactyla.HYPHY.tsv', quote=T, sep='\t', col.names = NA)
Birds1_df<- df[df$Group=="Birds1",]
Birds1_df$RELAX_adj.pval <- p.adjust(Birds1_df$RELAX_pval, method = "fdr")
write.table(Birds1_df, file='Birds1.HYPHY.tsv', quote=T, sep='\t', col.names = NA)
Birds2_df<- df[df$Group=="Birds2",]
Birds2_df$RELAX_adj.pval <- p.adjust(Birds2_df$RELAX_pval, method = "fdr")
write.table(Birds2_df, file='Birds2.HYPHY.tsv', quote=T, sep='\t', col.names = NA)
Birds3_df<- df[df$Group=="Birds3",]
Birds3_df$RELAX_adj.pval <- p.adjust(Birds3_df$RELAX_pval, method = "fdr")
write.table(Birds3_df, file='Birds3.HYPHY.tsv', quote=T, sep='\t', col.names = NA)
Carnivora_df<- df[df$Group=="Carnivora",]
Carnivora_df$RELAX_adj.pval <- p.adjust(Carnivora_df$RELAX_pval, method = "fdr")
write.table(Carnivora_df, file='Carnivora.HYPHY.tsv', quote=T, sep='\t', col.names = NA)
Chiroptera_df<- df[df$Group=="Chiroptera",]
Chiroptera_df$RELAX_adj.pval <- p.adjust(Chiroptera_df$RELAX_pval, method = "fdr")
write.table(Chiroptera_df, file='Chiroptera.HYPHY.tsv', quote=T, sep='\t', col.names = NA)
Eulipotyphla_df<- df[df$Group=="Eulipotyphla",]
Eulipotyphla_df$RELAX_adj.pval <- p.adjust(Eulipotyphla_df$RELAX_pval, method = "fdr")
write.table(Eulipotyphla_df, file='Eulipotyphla.HYPHY.tsv', quote=T, sep='\t', col.names = NA)
Lagomorpha_df<- df[df$Group=="Lagomorpha",]
Lagomorpha_df$RELAX_adj.pval <- p.adjust(Lagomorpha_df$RELAX_pval, method = "fdr")
write.table(Lagomorpha_df, file='Lagomorpha.HYPHY.tsv', quote=T, sep='\t', col.names = NA)
Metatheria_Monotremata_df<- df[df$Group=="Metatheria_Monotremata",]
Metatheria_Monotremata_df$RELAX_adj.pval <- p.adjust(Metatheria_Monotremata_df$RELAX_pval, method = "fdr")
write.table(Metatheria_Monotremata_df, file='Metatheria_Monotremata.HYPHY.tsv', quote=T, sep='\t', col.names = NA)
Perissodactyla_df<- df[df$Group=="Perissodactyla",]
Perissodactyla_df$RELAX_adj.pval <- p.adjust(Perissodactyla_df$RELAX_pval, method = "fdr")
write.table(Perissodactyla_df, file='Perissodactyla.HYPHY.tsv', quote=T, sep='\t', col.names = NA)
Primates_df<- df[df$Group=="Primates",]
Primates_df$RELAX_adj.pval <- p.adjust(Primates_df$RELAX_pval, method = "fdr")
write.table(Primates_df, file='Primates.HYPHY.tsv', quote=T, sep='\t', col.names = NA)
Rodentia_df<- df[df$Group=="Rodentia",]
Rodentia_df$RELAX_adj.pval <- p.adjust(Rodentia_df$RELAX_pval, method = "fdr")
write.table(Rodentia_df, file='Rodentia.HYPHY.tsv', quote=T, sep='\t', col.names = NA)
Squamata_df<- df[df$Group=="Squamata",]
Squamata_df$RELAX_adj.pval <- p.adjust(Squamata_df$RELAX_pval, method = "fdr")
write.table(Squamata_df, file='Squamata.HYPHY.tsv', quote=T, sep='\t', col.names = NA)
Testudines_df<- df[df$Group=="Testudines",]
Testudines_df$RELAX_adj.pval <- p.adjust(Testudines_df$RELAX_pval, method = "fdr")
write.table(Testudines_df, file='Testudines.HYPHY.tsv', quote=T, sep='\t', col.names = NA)
Xenarthra_df<- df[df$Group=="Xenarthra",]
Xenarthra_df$RELAX_adj.pval <- p.adjust(Xenarthra_df$RELAX_pval, method = "fdr")
write.table(Xenarthra_df, file='Xenarthra.HYPHY.tsv', quote=T, sep='\t', col.names = NA)

Final_HYPHY_RELAX<-rbind(Afrotheria_df,Amphibia_df,Artiodactyla_df,Birds1_df,Birds2_df,Birds3_df,Carnivora_df,Chiroptera_df,Eulipotyphla_df,Lagomorpha_df,Metatheria_Monotremata_df,Perissodactyla_df,Primates_df,Rodentia_df,Squamata_df,Testudines_df,Xenarthra_df)
write.table(Final_HYPHY_RELAX, file='HYPHY_Results_padj.tsv', quote=T, sep='\t', col.names = NA)
