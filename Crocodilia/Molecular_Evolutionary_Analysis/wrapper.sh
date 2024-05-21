clade=$1

./fel1.sh $clade &
./meme1.sh $clade &
./relax.sh $clade &
./codeml.sh $clade &
./aBSREL.sh $clade &
./gBGC.sh $clade &
./BUSTED.sh $clade &
