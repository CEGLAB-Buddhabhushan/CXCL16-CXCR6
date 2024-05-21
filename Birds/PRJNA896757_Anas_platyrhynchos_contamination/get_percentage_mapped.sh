echo -e "SRR_Acc\tHspercentage\tAppercentage" > PRJNA896757_Anas_platyrhynchos_contamination.tsv
for i in *.bam
do

bam_file=$i
SRR_id=`echo $bam_file|sed 's/\.bam//g'`
total_reads=$(samtools view -c "$bam_file")
#Hs
Hstotal_mapped_reads=0
while IFS= read -r chromosome; do
    mapped_reads=$(samtools view -c "$bam_file" "$chromosome")
    Hstotal_mapped_reads=$((Hstotal_mapped_reads + mapped_reads))
done < "Homo_sapiens_chr.lst"

#Ap
Aptotal_mapped_reads=0
while IFS= read -r chromosome; do
    mapped_reads=$(samtools view -c "$bam_file" "$chromosome")
    Aptotal_mapped_reads=$((Aptotal_mapped_reads + mapped_reads))
done < "Anas_platyrhynchos_chr.lst"


Hspercentage=$(echo "scale=2; ($Hstotal_mapped_reads / $total_reads) * 100" | bc)
Appercentage=$(echo "scale=2; ($Aptotal_mapped_reads / $total_reads) * 100" | bc)

echo $SRR_id $Hspercentage $Appercentage|sed 's/ /\t/g' >> PRJNA896757_Anas_platyrhynchos_contamination.tsv
done
