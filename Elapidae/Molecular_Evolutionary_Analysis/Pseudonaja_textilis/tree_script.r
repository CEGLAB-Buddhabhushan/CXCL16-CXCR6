library(ape)
a<-read.tree("Pseudonaja_textilis.nwk")
b<-unroot(a)
write.tree(b,"Pseudonaja_textilis.nwk.tree")
