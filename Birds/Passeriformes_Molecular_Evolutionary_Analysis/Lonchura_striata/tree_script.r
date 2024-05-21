library(ape)
a<-read.tree("Lonchura_striata.nwk")
b<-unroot(a)
write.tree(b,"Lonchura_striata.nwk.tree")
