library(ape)
a<-read.tree("Birds2.nwk")
b<-unroot(a)
write.tree(b,"Birds2.nwk.tree")
