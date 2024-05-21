## gene feature
for i in *.fa
do
makeblastdb -in $i -out $i -dbtype nucl
blastn -task blastn -evalue 0.01 -db $i -out blastn.Ostrich_Exon14_15."$i".6out -num_threads 4 -outfmt "6 sseqid sstart send qseqid" -query /home/ceglab358/BUDDHA/CXCR6/circos_plot/1kb/circos_data/Ostrich_Exon14_15.fa
echo $i
done

## links
for i in Anas_platyrhynchos.fa
do
makeblastdb -in $i -out $i -dbtype nucl
blastn -task blastn -evalue 0.01 -db $i -out blastn.Anas_platyrhynchos.Gallus_gallus.6out -num_threads 4 -outfmt "6 sseqid sstart send qseqid qstart qend" -query Gallus_gallus.fa
echo $i
done




for i in *.fa
do
/home/bbgs/softwares/Repeatmasker/RepeatMasker/RepeatMasker $i -pa 16 -s -cutoff 250 -species Birds
done

rmsk2bed < $i |cut -f1-3,11|sed 's/\t/ /g' >> Repeatmasker.bed
