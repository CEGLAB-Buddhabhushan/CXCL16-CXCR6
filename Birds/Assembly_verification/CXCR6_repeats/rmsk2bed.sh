rmsk2bed < Taeniopygia_guttata_chr2.fa.out|awk '{print $1"\t"$2"\t"$3"\t"$11"\t"$5"\t"$6}' > Taeniopygia_guttata_chr2.fa.out.repeat.bed
rmsk2bed < Anas_platyrhynchos_chr2.fa.out|awk '{print $1"\t"$2"\t"$3"\t"$11"\t"$5"\t"$6}' > Anas_platyrhynchos_chr2.fa.out.repeat.bed
rmsk2bed < Gallus_gallus_chr2.fa.out|awk '{print $1"\t"$2"\t"$3"\t"$11"\t"$5"\t"$6}' > Gallus_gallus_chr2.fa.out.repeat.bed
