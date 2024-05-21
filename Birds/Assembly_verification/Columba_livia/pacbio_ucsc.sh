samtools view -b SRR10539283.PacBio.sorted.bam CM070350.1:46728330-49079339 > CXCR6_PacBio_subseted.bam

bamToBed -i CXCR6_PacBio_subseted.bam > CXCR6_PacBio_subseted.bed

awk '{print $0,$3-$2}' CXCR6_PacBio_subseted.bed  | awk '$7 >= 20000 {print $0}'  > CXCR6_PacBio_subseted_20kb.bed

