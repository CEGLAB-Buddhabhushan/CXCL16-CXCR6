samtools view -b packbio_merged.sorted.bam CM020385.1:1088481-1169818 > CXCR6_PacBio_subseted.bam

bamToBed -i CXCR6_PacBio_subseted.bam > CXCR6_PacBio_subseted.bed

awk '{print $0,$3-$2}' CXCR6_PacBio_subseted.bed  | awk '$7 >= 20000 {print $0}'  > CXCR6_PacBio_subseted_20kb.bed
