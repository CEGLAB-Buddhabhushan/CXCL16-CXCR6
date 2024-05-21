library(ape)
a<-read.tree("Alligator_sinensis.nwk")
b<-unroot(a)
write.tree(b,"Alligator_sinensis.nwk.tree")
