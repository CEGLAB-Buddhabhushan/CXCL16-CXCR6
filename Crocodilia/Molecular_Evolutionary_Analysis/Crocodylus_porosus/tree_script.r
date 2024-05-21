library(ape)
a<-read.tree("Crocodylus_porosus.nwk")
b<-unroot(a)
write.tree(b,"Crocodylus_porosus.nwk.tree")
