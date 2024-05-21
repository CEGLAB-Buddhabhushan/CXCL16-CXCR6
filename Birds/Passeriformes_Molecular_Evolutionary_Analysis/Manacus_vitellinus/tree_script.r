library(ape)
a<-read.tree("Manacus_vitellinus.nwk")
b<-unroot(a)
write.tree(b,"Manacus_vitellinus.nwk.tree")
