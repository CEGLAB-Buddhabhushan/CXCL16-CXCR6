samtools view -b packbio_merged.sorted.bam NC_071615.1:20864878-20943723 > CXCR6_PacBio_subseted.bam

bamToBed -i CXCR6_PacBio_subseted.bam > CXCR6_PacBio_subseted.bed

awk '{print $0,$3-$2}' CXCR6_PacBio_subseted.bed  | awk '$7 >= 20000 {print $0}'  > CXCR6_PacBio_subseted_20kb.bed
