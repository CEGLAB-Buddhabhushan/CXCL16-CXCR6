library(ape)
a<-read.tree("Taeniopygia_guttata.nwk")
b<-unroot(a)
write.tree(b,"Taeniopygia_guttata.nwk.tree")
