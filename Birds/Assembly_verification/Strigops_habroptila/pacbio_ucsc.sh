samtools view -b packbio_merged.sorted.bam NC_044277.2:143109722-143168999 > CXCR6_PacBio_subseted.bam

bamToBed -i CXCR6_PacBio_subseted.bam > CXCR6_PacBio_subseted.bed

awk '{print $0,$3-$2}' CXCR6_PacBio_subseted.bed  | awk '$7 >= 10000 {print $0}'  > CXCR6_PacBio_subseted_10kb.bed
