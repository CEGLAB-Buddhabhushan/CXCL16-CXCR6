echo -e "Group\tSpecies_name\tGC" > GC_content.tsv
for i in *.fa; do
sp=$(echo "$i" | sed 's/\.fa//g')
seqkit fx2tab --name --gc "$i" | awk -v species="$sp" '{print species "\t" $0}' >> GC_content.tsv
done

Rscript ../gc_content.R

for i in Afrotheria Amphibia Artiodactyla Aves Carnivora Chiroptera Eulipotyphla Lagomorpha Metatheria_Monotremata Perissodactyla Pholidota Primates Rodentia Squamata Testudines Xenarthra; do perl ../GC_Stretch_finder.pl "$i".fa | cut -f2,5 -d' ' | sed 's/, /\t/g' | sed "s/^/$i\t/" >>Avg_GC_strench.tsv; done

echo -e "Group\tSpecies_name\tGC_content\tGC_Stretch" > GC_content-GC_Stretch.tsv

for i in `cut -f2 Avg_GC_strench.tsv`
do
Group=`grep "$i" Avg_GC_strench.tsv|cut -f1`
Species_name=`echo $i`
GC_Stretch=`grep "$i" Avg_GC_strench.tsv|cut -f3`
GC_content=`grep "$i" GC_content.tsv|cut -f3`
echo -e "$Group\t$Species_name\t$GC_content\t$GC_Stretch" >> GC_content-GC_Stretch.tsv
done
