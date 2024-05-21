library(ape)
a<-read.tree("Dermochelys_coriacea.nwk")
b<-unroot(a)
write.tree(b,"Dermochelys_coriacea.nwk.tree")
