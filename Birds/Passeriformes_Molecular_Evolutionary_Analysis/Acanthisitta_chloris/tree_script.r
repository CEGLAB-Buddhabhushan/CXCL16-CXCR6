library(ape)
a<-read.tree("Acanthisitta_chloris.nwk")
b<-unroot(a)
write.tree(b,"Acanthisitta_chloris.nwk.tree")
