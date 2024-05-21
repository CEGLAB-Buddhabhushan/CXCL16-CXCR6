clade=$1

./fel1.sh $clade &
./meme1.sh $clade &
./relax.sh $clade &
./codeml.sh $clade &
./aBSREL1.sh $clade &
./gBGC.sh $clade &
./BUSTED1.sh $clade &
