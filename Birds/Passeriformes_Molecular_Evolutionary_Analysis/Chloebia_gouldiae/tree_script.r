library(ape)
a<-read.tree("Chloebia_gouldiae.nwk")
b<-unroot(a)
write.tree(b,"Chloebia_gouldiae.nwk.tree")
