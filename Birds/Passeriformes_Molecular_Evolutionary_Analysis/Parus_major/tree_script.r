library(ape)
a<-read.tree("Parus_major.nwk")
b<-unroot(a)
write.tree(b,"Parus_major.nwk.tree")
