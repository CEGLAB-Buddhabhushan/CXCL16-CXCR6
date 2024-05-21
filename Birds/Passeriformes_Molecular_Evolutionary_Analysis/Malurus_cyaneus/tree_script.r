library(ape)
a<-read.tree("Malurus_cyaneus.nwk")
b<-unroot(a)
write.tree(b,"Malurus_cyaneus.nwk.tree")
