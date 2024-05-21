library(ape)
a<-read.tree("Corvus_brachyrhynchos.nwk")
b<-unroot(a)
write.tree(b,"Corvus_brachyrhynchos.nwk.tree")
