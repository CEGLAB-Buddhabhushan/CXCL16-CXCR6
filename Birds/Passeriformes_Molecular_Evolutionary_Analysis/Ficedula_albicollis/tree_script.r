library(ape)
a<-read.tree("Ficedula_albicollis.nwk")
b<-unroot(a)
write.tree(b,"Ficedula_albicollis.nwk.tree")
