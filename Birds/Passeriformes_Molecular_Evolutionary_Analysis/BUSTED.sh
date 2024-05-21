##generate BUSTED output using HYPHY
clade=$1
cd $clade
mkdir BUSTED
cp "$clade".aln "$clade".nwk BUSTED
cd BUSTED
tree="$clade".nwk
for i in "$clade".aln
do
t=`grep ">" $i|wc -l`
grep ">" $i|sed 's/>//g' > taxlist.txt
for j in `cat taxlist.txt|head -1`
do
sed "s/$j/$j{fg}/g" $tree > "$j"_treeLabled.txt
echo -e "1\n5\n1\n"$PWD"/$i\n"$PWD"/"$j"_treeLabled.txt\n5" > "$j"_tree.config
HYPHYMP <"$j"_tree.config > "$j"_treeoutput_BUSTED
done
done


##makking table

echo -e "test pval"|sed 's/ /\t/g' > HYPHY_BUSTED.Results.txt
for d in *_BUSTED
do
pval=$(grep "Likelihood ratio test for episodic diversifying positive selection" "$d" | cut -f2 -d'=' | sed 's/ //g;s/[*]//g;s/\.//2')
test=$(grep "Selected 1 branches to test in the BUSTED analysis:" "$d" | cut -f2 -d':' | sed 's/ //g; s/`//g')

if [ -z "$pval" ]
then pval="NA"
fi

echo -e "$test\t$pval" >> HYPHY_BUSTED.Results.txt
done

cd ../..
