library(ape)
a<-read.tree("Hydrophis_cyanocinctus.nwk")
b<-unroot(a)
write.tree(b,"Hydrophis_cyanocinctus.nwk.tree")
