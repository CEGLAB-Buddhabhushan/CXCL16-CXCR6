library(ape)
a<-read.tree("Metatheria_Monotremata.nwk")
b<-unroot(a)
write.tree(b,"Metatheria_Monotremata.nwk.tree")
