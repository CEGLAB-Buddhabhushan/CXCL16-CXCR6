library(ape)
a<-read.tree("Toxicofera.nwk")
b<-unroot(a)
write.tree(b,"Toxicofera.nwk.tree")
