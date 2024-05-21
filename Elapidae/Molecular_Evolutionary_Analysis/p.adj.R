
hyphy<- read.table("HYPHY_RELAX_output.tsv", sep = "\t", header  = T)
df <- data.frame(hyphy)


df$adjusted_p_value <- p.adjust(df$pval, method = "fdr")
write.table(df, file='Elapidae_selection.HYPHY-RELAX.tsv', quote=T, sep='\t', col.names = NA)
