library(ape)
a<-read.tree("Zonotrichia_albicollis.nwk")
b<-unroot(a)
write.tree(b,"Zonotrichia_albicollis.nwk.tree")
