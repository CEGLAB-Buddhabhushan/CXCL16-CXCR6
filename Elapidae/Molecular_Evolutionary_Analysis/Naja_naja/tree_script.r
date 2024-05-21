library(ape)
a<-read.tree("Naja_naja.nwk")
b<-unroot(a)
write.tree(b,"Naja_naja.nwk.tree")
