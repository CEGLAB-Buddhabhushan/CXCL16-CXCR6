CM057603.1:7,651,900-7,661,765
samtools view -b m64055e_220302_034217_m64330e_220309_203801.minimap2.sorted.bam CM057603.1:7651900-7661765 > Gavialis_gangeticus.subseted.bam

bamToBed -i Gavialis_gangeticus.subseted.bam > Gavialis_gangeticus.subseted.bed

awk '{print $0,$3-$2}' Gavialis_gangeticus.subseted.bed  | awk '$7 >= 5000 {print $0}'  > Gavialis_gangeticus.subseted.5kb.bed
