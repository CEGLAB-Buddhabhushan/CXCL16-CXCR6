library(ape)
a<-read.tree("Testudines_Squamata.nwk")
b<-unroot(a)
write.tree(b,"Testudines_Squamata.nwk.tree")
