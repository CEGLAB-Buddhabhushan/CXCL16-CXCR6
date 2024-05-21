##generate aBSREL output using HYPHY
clade=$1
cd $clade
mkdir aBSREL
cp "$clade".aln "$clade".nwk aBSREL
cd aBSREL
tree="$clade".nwk
for i in "$clade".aln
do
t=`grep ">" $i|wc -l`
grep ">" $i|sed 's/>//g' > taxlist.txt
for j in `cat taxlist.txt|head -1`
do
sed "s/$j/$j{fg}/g" $tree > "$j"_treeLabled.txt
echo -e "1\n6\n1\n"$PWD"/$i\n"$PWD"/"$j"_treeLabled.txt\n5" > "$j"_tree.config
HYPHYMP <"$j"_tree.config > "$j"_treeoutput_aBSREL
done
done


##makking table

echo -e "test pval"|sed 's/ /\t/g' > HYPHY_aBSREL.Results.txt
for d in *_aBSREL
do
pval=$(grep ", p-value =  " "$d" | cut -f2 -d'=' | sed 's/ //g')
test=$(grep "Selected 1 branches for testing:" "$d" | cut -f2 -d':' | sed 's/ //g; s/`//g')
if [ -z "$pval" ]
then pval="NA"
fi

echo -e "$test\t$pval" >> HYPHY_aBSREL.Results.txt
done

cd ../..
