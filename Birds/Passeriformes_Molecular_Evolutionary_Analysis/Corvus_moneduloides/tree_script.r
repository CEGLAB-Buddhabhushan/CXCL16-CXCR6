library(ape)
a<-read.tree("Corvus_moneduloides.nwk")
b<-unroot(a)
write.tree(b,"Corvus_moneduloides.nwk.tree")
