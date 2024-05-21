library(ape)
a<-read.tree("Alligator_mississippiensis.nwk")
b<-unroot(a)
write.tree(b,"Alligator_mississippiensis.nwk.tree")
