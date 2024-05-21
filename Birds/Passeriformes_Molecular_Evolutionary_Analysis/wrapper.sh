clade=$1

./fel.sh $clade &
./meme.sh $clade &
./relax.sh $clade &
./codeml.sh $clade &
./aBSREL.sh $clade &
./gBGC.sh $clade &
./BUSTED.sh $clade &
