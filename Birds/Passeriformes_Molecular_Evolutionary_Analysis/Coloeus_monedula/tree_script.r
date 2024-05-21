library(ape)
a<-read.tree("Coloeus_monedula.nwk")
b<-unroot(a)
write.tree(b,"Coloeus_monedula.nwk.tree")
