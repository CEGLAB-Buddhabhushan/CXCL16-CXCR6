library(ape)
a<-read.tree("Geospiza_fortis.nwk")
b<-unroot(a)
write.tree(b,"Geospiza_fortis.nwk.tree")
