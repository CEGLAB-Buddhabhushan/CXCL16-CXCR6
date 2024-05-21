library(ape)
a<-read.tree("Serinus_canaria.nwk")
b<-unroot(a)
write.tree(b,"Serinus_canaria.nwk.tree")
