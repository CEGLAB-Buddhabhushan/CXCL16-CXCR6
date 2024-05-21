samtools view -b SRR25387057_NC_067283.1.sorted.bam NC_067283.1:45415331-47223235 > CXCR6_PacBio_subseted.bam

bamToBed -i CXCR6_PacBio_subseted.bam > CXCR6_PacBio_subseted.bed

awk '{print $0,$3-$2}' CXCR6_PacBio_subseted.bed  | awk '$7 >= 20000 {print $0}'  > CXCR6_PacBio_subseted_20kb.bed
