codeml<- read.table("Codeml_output.tsv", sep = "\t", header  = T)
df <- data.frame(codeml)

df$adjusted_pvalm0_bfree <- p.adjust(df$pvalm0_bfree, method = "fdr")
df$adjusted_pavalbne_bfree <- p.adjust(df$pavalbne_bfree, method = "fdr")
write.table(df, file='Crocodylia_selection.PAML-codeML.tsv', quote=T, sep='\t', col.names = NA)

