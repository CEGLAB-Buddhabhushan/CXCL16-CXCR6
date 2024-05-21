hyphy<- read.table("HYPHY_RELAX_output.tsv", sep = "\t", header  = T)
df <- data.frame(hyphy)
df$RELAX_adj.pval <- p.adjust(df$pval, method = "fdr")
write.table(df, file='Passeriformes_selection.HYPHY.tsv', quote=T, sep='\t', col.names = NA)

