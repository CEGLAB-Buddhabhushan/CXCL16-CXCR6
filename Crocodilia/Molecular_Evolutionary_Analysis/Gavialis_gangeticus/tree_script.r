library(ape)
a<-read.tree("Gavialis_gangeticus.nwk")
b<-unroot(a)
write.tree(b,"Gavialis_gangeticus.nwk.tree")
