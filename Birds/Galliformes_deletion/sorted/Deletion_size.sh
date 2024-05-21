### get FYCO1 scafold
### get 5kb slop
for i in `cat Species.lst`
do
makeblastdb -in "$i"_CXCR6_query.fa -out "$i"_CXCR6_query.fa -dbtype nucl
blastn -task blastn -evalue 0.001 -db "$i"_CXCR6_query.fa -out blastn."$i".6out -num_threads 4 -outfmt "6 sseqid sstart send qseqid" -query Struthio_camelus.FYCO1.Exon14-15.fa
chr=`cut -f1 blastn."$i".6out|head -1`
start=`cut -f2 blastn."$i".6out|sort -n|head -1`
end=`cut -f3 blastn."$i".6out|sort -rn|head -1`
echo -e $chr"\t"$start"\t"$end > "$i".bed
samtools faidx "$i"_CXCR6_query.fa
cut -f 1,2 "$i"_CXCR6_query.fa.fai >"$i"_CXCR6_query.fa.chrom.sizes
bedtools slop -i "$i".bed -g "$i"_CXCR6_query.fa.chrom.sizes -b 5000 > "$i".slopBed_5kb.bed
bedtools getfasta -fi "$i"_CXCR6_query.fa -bed "$i".slopBed_5kb.bed -fo 5kb/"$i".getFastaFromBed.fa
done
###Deletion In galliforms
makeblastdb -in Anas_platyrhynchos_chr2.fa.masked -out Anas_platyrhynchos_chr2.fa.masked -dbtype nucl
for i in *.fa
do

species_name=`echo $i|sed 's/\.getFastaFromBed.fa//g'`
echo $species_name

blastn -task blastn -evalue 0.05 -db Anas_platyrhynchos_chr2.fa.masked -out blastn."$species_name".Anas_platyrhynchos.out -num_threads 8 -outfmt 6 -query $i

cat blastn."$species_name".Anas_platyrhynchos.out|sort -nrk4 > "$species_name".all
blast2bed "$species_name".all
grep -v "#" "$species_name".all.bed|sort -k1,1 -k2,2n > "$species_name".all_sorted.bed

echo "track name=""$species_name" " visibility=2 color="255,0,0"" |sed 's/_/ /g;s/name=/name="/g;s/  visibility=/"  visibility=/g;s/color=255,0,0/color="255,0,0"/g' >"$species_name"_merge.bed

bedtools merge -i "$species_name".all_sorted.bed -d 5000 >> "$species_name"_merge.bed
cat "$species_name"_merge.bed >> All_masked_merge.bed
echo "track name=""$species_name" " visibility=2 color="255,0,0"" |sed 's/_/ /g;s/name=/name="/g;s/  visibility=/"  visibility=/g;s/color=255,0,0/color="255,0,0"/g' > "$species_name".bed
cat "$species_name".all_sorted.bed|cut -f1 -d':' >>  "$species_name".bed
cat "$species_name".bed >> All_masked_without_merge.bed
done

for i in `cat ../Species.lst` 
do
species_name=`echo $i`

bedtools intersect -a "$species_name"_merge.bed -b intersect.BED > "$species_name"_sorted_intersect.bed

chr_name=`cut -f1 "$species_name"_sorted_intersect.bed|uniq`
start=`cut -f2,3 "$species_name"_sorted_intersect.bed|tr '\t' '\n'|sort -nr|head -3|tail -1`
end=`cut -f2,3 "$species_name"_sorted_intersect.bed|tr '\t' '\n'|sort -nr|head -2|tail -1`
deletion=$(expr $end - $start)
echo  -e "$chr_name\t$start\t$end\t$species_name\t$deletion"  >> deleted.bed
done

####Dot-plot xlcproc
makeblastdb -in Anas_platyrhynchos.getFastaFromBed.fa -out Anas_platyrhynchos.getFastaFromBed.fa -dbtype nucl
for i in *.fa
do
species_name=`echo $i|sed 's/\.getFastaFromBed.fa//g'`
echo $species_name
blastn -task blastn -evalue 0.05 -db Anas_platyrhynchos.getFastaFromBed.fa -out blastn."$species_name".Anas_platyrhynchos.xml -num_threads 8 -outfmt 5 -query $i
xsltproc --novalid  /home/ceglab358/BUDDHA/Tools/xslt-sandbox/stylesheets/bio/ncbi/blast2dotplot.xsl blastn."$species_name".Anas_platyrhynchos.xml > "$species_name".Anas_platyrhynchos.dotplot.html
done

