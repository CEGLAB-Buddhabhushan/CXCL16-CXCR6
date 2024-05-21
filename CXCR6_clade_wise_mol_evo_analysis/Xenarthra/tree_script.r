library(ape)
a<-read.tree("Xenarthra.nwk")
b<-unroot(a)
write.tree(b,"Xenarthra.nwk.tree")
