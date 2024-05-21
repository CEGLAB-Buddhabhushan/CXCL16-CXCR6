library(ape)
a<-read.tree("Oriolus_oriolus.nwk")
b<-unroot(a)
write.tree(b,"Oriolus_oriolus.nwk.tree")
