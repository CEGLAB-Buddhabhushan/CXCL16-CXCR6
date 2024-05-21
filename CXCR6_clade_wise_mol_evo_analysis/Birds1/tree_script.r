library(ape)
a<-read.tree("Birds1.nwk")
b<-unroot(a)
write.tree(b,"Birds1.nwk.tree")
