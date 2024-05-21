library(ape)
a<-read.tree("Birds3.nwk")
b<-unroot(a)
write.tree(b,"Birds3.nwk.tree")
