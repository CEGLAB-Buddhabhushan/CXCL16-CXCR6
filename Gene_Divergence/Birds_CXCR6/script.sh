
faSplit byname BIRDS.fa query/
echo "species ident"|sed 's/ /\t/g' > Birds_CXCR6_identity_wrt_mallard.out
for i in *.fa
do
n=`echo $i|sed 's/\.fa//g'`
needle -asequence ../Anas_platyrhynchos.fa -bsequence $i -outfile Anas_platyrhynchos-"$n".needle.out -gapopen 10.0 -gapextend 0.5
sim=`grep "Similarity" Anas_platyrhynchos-"$n".needle.out |awk '{print $4}'|sed 's/(//g'|sed 's/)//g'|sed 's/%//g'`
ident=`grep "Identity" Anas_platyrhynchos-"$n".needle.out |awk '{print $4}'|sed 's/(//g'|sed 's/)//g'|sed 's/%//g'`
gaps=`grep "Gaps" Anas_platyrhynchos-"$n".needle.out |awk '{print $5}'|sed 's/(//g'|sed 's/)//g'|sed 's/%//g'`
echo $n $ident|sed 's/ /\t/g' >> Birds_CXCR6_identity_wrt_mallard.out
done
