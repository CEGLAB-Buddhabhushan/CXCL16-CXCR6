for i in Anas_platyrhynchos_chr2.fa Gallus_gallus_chr2.fa Taeniopygia_guttata_chr2.fa 
do
/home/bbgs/softwares/Repeatmasker/RepeatMasker/RepeatMasker $i -pa 16 -s -cutoff 250 -species Birds
done
