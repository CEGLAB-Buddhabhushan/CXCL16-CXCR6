#biomart download and sorting cds with 300 nt or more
awk -F'|' '$3>299 {print $0}' mart_export.txt|sed 's/>//g' > gene_list_longer300.lst
seqtk subseq mart_export.txt gene_list_longer300.lst > Chicken_CDS.fa

echo -e "Group\tSpecies_name\tAvg_GC" >Avg_GC_strench.tsv

for i in Afrotheria Amphibia Artiodactyla Aves Carnivora Chiroptera Eulipotyphla Lagomorpha Metatheria Perissodactyla Pholidota Primates Rodentia Squamata Testudines Xenarthra
do
perl GC_Stretch_finder.pl "$i".fa | cut -f2,5 -d' ' | sed 's/, /\t/g' | sed "s/^/$i\t/" >>Avg_GC_strench.tsv
done

