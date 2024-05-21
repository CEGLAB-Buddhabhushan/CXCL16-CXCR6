library(ape)
a<-read.tree("Camarhynchus_parvulus.nwk")
b<-unroot(a)
write.tree(b,"Camarhynchus_parvulus.nwk.tree")
