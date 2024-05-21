codeml<- read.table("codeML_Results.tsv", sep = "\t", header  = T)
df <- data.frame(codeml)
Afrotheria_df<- df[df$Group=="Afrotheria",]
Afrotheria_df$adjusted_pvalm0_bfree <- p.adjust(Afrotheria_df$pvalm0_bfree, method = "fdr")
Afrotheria_df$adjusted_pavalbne_bfree <- p.adjust(Afrotheria_df$pavalbne_bfree, method = "fdr")
write.table(Afrotheria_df, file='Afrotheria.PAML-codeML.tsv', quote=T, sep='\t', col.names = NA)
Amphibia_df<- df[df$Group=="Amphibia",]
Amphibia_df$adjusted_pvalm0_bfree <- p.adjust(Amphibia_df$pvalm0_bfree, method = "fdr")
Amphibia_df$adjusted_pavalbne_bfree <- p.adjust(Amphibia_df$pavalbne_bfree, method = "fdr")
write.table(Amphibia_df, file='Amphibia.PAML-codeML.tsv', quote=T, sep='\t', col.names = NA)
Artiodactyla_df<- df[df$Group=="Artiodactyla",]
Artiodactyla_df$adjusted_pvalm0_bfree <- p.adjust(Artiodactyla_df$pvalm0_bfree, method = "fdr")
Artiodactyla_df$adjusted_pavalbne_bfree <- p.adjust(Artiodactyla_df$pavalbne_bfree, method = "fdr")
write.table(Artiodactyla_df, file='Artiodactyla.PAML-codeML.tsv', quote=T, sep='\t', col.names = NA)
Birds1_df<- df[df$Group=="Birds1",]
Birds1_df$adjusted_pvalm0_bfree <- p.adjust(Birds1_df$pvalm0_bfree, method = "fdr")
Birds1_df$adjusted_pavalbne_bfree <- p.adjust(Birds1_df$pavalbne_bfree, method = "fdr")
write.table(Birds1_df, file='Birds1.PAML-codeML.tsv', quote=T, sep='\t', col.names = NA)
Birds2_df<- df[df$Group=="Birds2",]
Birds2_df$adjusted_pvalm0_bfree <- p.adjust(Birds2_df$pvalm0_bfree, method = "fdr")
Birds2_df$adjusted_pavalbne_bfree <- p.adjust(Birds2_df$pavalbne_bfree, method = "fdr")
write.table(Birds2_df, file='Birds2.PAML-codeML.tsv', quote=T, sep='\t', col.names = NA)
Birds3_df<- df[df$Group=="Birds3",]
Birds3_df$adjusted_pvalm0_bfree <- p.adjust(Birds3_df$pvalm0_bfree, method = "fdr")
Birds3_df$adjusted_pavalbne_bfree <- p.adjust(Birds3_df$pavalbne_bfree, method = "fdr")
write.table(Birds3_df, file='Birds3.PAML-codeML.tsv', quote=T, sep='\t', col.names = NA)
Carnivora_df<- df[df$Group=="Carnivora",]
Carnivora_df$adjusted_pvalm0_bfree <- p.adjust(Carnivora_df$pvalm0_bfree, method = "fdr")
Carnivora_df$adjusted_pavalbne_bfree <- p.adjust(Carnivora_df$pavalbne_bfree, method = "fdr")
write.table(Carnivora_df, file='Carnivora.PAML-codeML.tsv', quote=T, sep='\t', col.names = NA)
Chiroptera_df<- df[df$Group=="Chiroptera",]
Chiroptera_df$adjusted_pvalm0_bfree <- p.adjust(Chiroptera_df$pvalm0_bfree, method = "fdr")
Chiroptera_df$adjusted_pavalbne_bfree <- p.adjust(Chiroptera_df$pavalbne_bfree, method = "fdr")
write.table(Chiroptera_df, file='Chiroptera.PAML-codeML.tsv', quote=T, sep='\t', col.names = NA)
Eulipotyphla_df<- df[df$Group=="Eulipotyphla",]
Eulipotyphla_df$adjusted_pvalm0_bfree <- p.adjust(Eulipotyphla_df$pvalm0_bfree, method = "fdr")
Eulipotyphla_df$adjusted_pavalbne_bfree <- p.adjust(Eulipotyphla_df$pavalbne_bfree, method = "fdr")
write.table(Eulipotyphla_df, file='Eulipotyphla.PAML-codeML.tsv', quote=T, sep='\t', col.names = NA)
Lagomorpha_df<- df[df$Group=="Lagomorpha",]
Lagomorpha_df$adjusted_pvalm0_bfree <- p.adjust(Lagomorpha_df$pvalm0_bfree, method = "fdr")
Lagomorpha_df$adjusted_pavalbne_bfree <- p.adjust(Lagomorpha_df$pavalbne_bfree, method = "fdr")
write.table(Lagomorpha_df, file='Lagomorpha.PAML-codeML.tsv', quote=T, sep='\t', col.names = NA)
Metatheria_Monotremata_df<- df[df$Group=="Metatheria_Monotremata",]
Metatheria_Monotremata_df$adjusted_pvalm0_bfree <- p.adjust(Metatheria_Monotremata_df$pvalm0_bfree, method = "fdr")
Metatheria_Monotremata_df$adjusted_pavalbne_bfree <- p.adjust(Metatheria_Monotremata_df$pavalbne_bfree, method = "fdr")
write.table(Metatheria_Monotremata_df, file='Metatheria_Monotremata.PAML-codeML.tsv', quote=T, sep='\t', col.names = NA)
Perissodactyla_df<- df[df$Group=="Perissodactyla",]
Perissodactyla_df$adjusted_pvalm0_bfree <- p.adjust(Perissodactyla_df$pvalm0_bfree, method = "fdr")
Perissodactyla_df$adjusted_pavalbne_bfree <- p.adjust(Perissodactyla_df$pavalbne_bfree, method = "fdr")
write.table(Perissodactyla_df, file='Perissodactyla.PAML-codeML.tsv', quote=T, sep='\t', col.names = NA)
Primates_df<- df[df$Group=="Primates",]
Primates_df$adjusted_pvalm0_bfree <- p.adjust(Primates_df$pvalm0_bfree, method = "fdr")
Primates_df$adjusted_pavalbne_bfree <- p.adjust(Primates_df$pavalbne_bfree, method = "fdr")
write.table(Primates_df, file='Primates.PAML-codeML.tsv', quote=T, sep='\t', col.names = NA)
Rodentia_df<- df[df$Group=="Rodentia",]
Rodentia_df$adjusted_pvalm0_bfree <- p.adjust(Rodentia_df$pvalm0_bfree, method = "fdr")
Rodentia_df$adjusted_pavalbne_bfree <- p.adjust(Rodentia_df$pavalbne_bfree, method = "fdr")
write.table(Rodentia_df, file='Rodentia.PAML-codeML.tsv', quote=T, sep='\t', col.names = NA)
Squamata_df<- df[df$Group=="Squamata",]
Squamata_df$adjusted_pvalm0_bfree <- p.adjust(Squamata_df$pvalm0_bfree, method = "fdr")
Squamata_df$adjusted_pavalbne_bfree <- p.adjust(Squamata_df$pavalbne_bfree, method = "fdr")
write.table(Squamata_df, file='Squamata.PAML-codeML.tsv', quote=T, sep='\t', col.names = NA)
Testudines_df<- df[df$Group=="Testudines",]
Testudines_df$adjusted_pvalm0_bfree <- p.adjust(Testudines_df$pvalm0_bfree, method = "fdr")
Testudines_df$adjusted_pavalbne_bfree <- p.adjust(Testudines_df$pavalbne_bfree, method = "fdr")
write.table(Testudines_df, file='Testudines.PAML-codeML.tsv', quote=T, sep='\t', col.names = NA)
Xenarthra_df<- df[df$Group=="Xenarthra",]
Xenarthra_df$adjusted_pvalm0_bfree <- p.adjust(Xenarthra_df$pvalm0_bfree, method = "fdr")
Xenarthra_df$adjusted_pavalbne_bfree <- p.adjust(Xenarthra_df$pavalbne_bfree, method = "fdr")
write.table(Xenarthra_df, file='Xenarthra.PAML-codeML.tsv', quote=T, sep='\t', col.names = NA)

Final_PAML_codeML<-rbind(Afrotheria_df,Amphibia_df,Artiodactyla_df,Birds1_df,Birds2_df,Birds3_df,Carnivora_df,Chiroptera_df,Eulipotyphla_df,Lagomorpha_df,Metatheria_Monotremata_df,Perissodactyla_df,Primates_df,Rodentia_df,Squamata_df,Testudines_df,Xenarthra_df)
write.table(Final_PAML_codeML, file='Final.PAML-codeML.tsv', quote=T, sep='\t', col.names = NA)
