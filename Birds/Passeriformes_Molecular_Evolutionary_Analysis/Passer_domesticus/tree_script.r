library(ape)
a<-read.tree("Passer_domesticus.nwk")
b<-unroot(a)
write.tree(b,"Passer_domesticus.nwk.tree")
