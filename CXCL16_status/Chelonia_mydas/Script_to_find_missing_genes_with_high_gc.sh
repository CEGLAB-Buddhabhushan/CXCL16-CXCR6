### recovery of CXCL16 in Chelonia_mydas
#1- perform online blast using Caretta caretta MED11 (XM_048834055.1), CXCL16 (XM_048834045.1), and ZMYND15 (XM_048834056.1) genes as query against the Chelonia mydas pacbio SRA database
#2- extract the common read for three genes i.e SRR25743026.493011
comm -12 MED11-CXCL16.sorted.lst ZMYND15.sorted.lst
#3- extract the common read from fastq file 
seqtk subseq SRR25743026.fastq.gz SRR25743026.493011.lst > SRR25743026.493011.fq
sed -n '1~4s/^@/>/p;2~4p' SRR25743026.493011.fq > SRR25743026.493011.fa
#4- map Chelonia_mydas RNA seq data onto this read
STAR --runThreadN 16 --runMode genomeGenerate --genomeDir . --genomeFastaFiles SRR25743026.493011.fa --genomeSAindexNbases 8
for i in *_1.fastq.gz
do
j=`echo $i|sed 's/_1/_2/g'`
k=`echo $i|sed 's/_1.fastq.gz//g'`
STAR --runThreadN 16 --outSAMtype BAM SortedByCoordinate --genomeDir . --readFilesIn $i $j --readFilesCommand zcat --outFileNamePrefix "$k"_
samtools index "$k"_*.bam
done
samtools merge -@ 8 SRR12540953_SRR14517642_SRR14839290.bam *Aligned.sortedByCoord.out.bam
samtools sort SRR12540953_SRR14517642_SRR14839290.bam -@ 8 -o SRR12540953_SRR14517642_SRR14839290.sorted.bam
samtools index SRR12540953_SRR14517642_SRR14839290.sorted.bam
#5- correction of read using pilon
java -Xmx300g -jar /media/kalki/CXCL16_revision/Anas_platyrhynchos/RNA-Seq/faSplit/ERR12875150.3600316/pilon-1.24.jar --genome SRR25743026.493011.fa --frags SRR12540953_SRR14517642_SRR14839290.sorted.bam --output pilon_SRR25743026.493011-SRR12540953_SRR14517642_SRR14839290 --fix all --mindepth 0.5 --changes --verbose --minqual 20 --minmq 20
#6- Gene assesment using TOGA
#for ref, download Chromosome 28 - NC_064500.1 of Caretta caretta
efetch -db nucleotide -id NC_064500.1  -format fasta > Caretta_caretta_chr28.fasta
#for annnotation download gtf of Caretta caretta
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/023/653/815/GCF_023653815.1_GSC_CCare_1.0/GCF_023653815.1_GSC_CCare_1.0_genomic.gtf.gz
#extarct CXCL16 transcript 
zcat GCF_023653815.1_GSC_CCare_1.0_genomic.gtf.gz|grep "XM_048834045.1" > Caretta_caretta_XM_048834045.1.gtf
#convert gtf to bed12
/mnt/disk4/BUDDHA/tools/ea-utils/clipper/gtf2bed Caretta_caretta_XM_048834045.1.gtf|sed 's/\./_/1' > Caretta_caretta_XM_048834045.1.bed12
# run make chain anf TOGA
for i in Caretta_caretta_chr28.fasta
do
sed -i 's/ .*//;s/\./_/' $i
target_name=`echo $i|cut -f1,2 -d'_'`
for j in pilon_SRR25743026.493011-SRR12540953_SRR14517642_SRR14839290.fasta
do
sed -i 's/ .*//;s/\./_/' $j
query_name=`echo $j|sed 's/\.fasta//g'`
/mnt/disk4/BUDDHA/tools/TOGA_new/make_lastz_chains/make_chains.py $target_name $query_name $i $j --chaining_memory 40 --project_dir chain_"$target_name"_"$query_name" --kt 
cd chain_"$target_name"_"$query_name"
mv query.2bit ../"$query_name".2bit
mv target.2bit ../"$target_name".2bit
mv "$target_name"."$query_name".final.chain.gz ../
cd ..
rm -r chain_"$target_name"_"$query_name"
for chain in "$target_name"."$query_name".final.chain.gz
do
bed_input=Caretta_caretta_XM_048834045.1.bed12
id=`cat $bed_input|cut -f4`
/mnt/disk4/BUDDHA/TOGA-1.1.14/toga.py $chain $bed_input "$target_name".2bit "$query_name".2bit --pn TOGA_"$target_name"_"$query_name" --nc /mnt/disk4/BUDDHA/TOGA-1.1.14/nextflow_config_files/ --cesar_bigmem_config /mnt/disk4/BUDDHA/TOGA-1.1.14/nextflow_config_files/cesar_bigmem_config.nf --cesar_jobs_num 500 --cesar_buckets 3,5,25,50 --ces --kt --chain_jobs_num 60 
/mnt/disk4/BUDDHA/TOGA-1.1.14/supply/plot_mutations.py --publication_mode_heni $bed_input TOGA_"$target_name"_"$query_name"/inact_mut_data.txt $id sorted/mutation_plot/"$query_name".svg
done
for toga in TOGA_"$target_name"_"$query_name"
do
cat $toga/inact_mut_data.txt| sed "s/$id/$query_name/g" >> sorted/"$clade".inact_mut_data.txt
orthology_classification=`cat $toga/orthology_classification.tsv|tail -1|cut -f5`; loss_summ=`cat $toga/loss_summ_data.tsv|tail -1|cut -f3`
echo -e "$query_name\t$orthology_classification\t$loss_summ" >> sorted/"$clade".orthology.loss_summ.tsv
cat $toga/codon.fasta |tail -2 |sed 's/ //g;s/X/N/g'|sed "s/>.*/>$query_name/g" >> sorted/"$clade".codon.fasta
cat $toga/nucleotide.fasta |tail -2 |sed 's/ //g'|sed "s/>.*/>$query_name/g" >> sorted/"$clade".nucleotide.fasta
done
done
done
#7- Confirmaion of expression using RNA seq, assembly verification using klumpy and, generation of IGV report
#Confirmaion of expression using RNA seq
STAR --runThreadN 16 --runMode genomeGenerate --genomeDir . --genomeFastaFiles pilon_SRR25743026.493011-SRR12540953_SRR14517642_SRR14839290.fasta --genomeSAindexNbases 8
for i in *_1.fastq.gz
do
j=`echo $i|sed 's/_1/_2/g'`
k=`echo $i|sed 's/_1.fastq.gz//g'`
STAR --runThreadN 16 --outSAMtype BAM SortedByCoordinate --genomeDir . --readFilesIn $i $j --readFilesCommand zcat --outFileNamePrefix "$k"_
samtools index "$k"_*.bam
done
# assembly verification
for i in SRR25743018.fastq.gz SRR25743022.fastq.gz SRR25743023.fastq.gz SRR25743024.fastq.gz SRR25743025.fastq.gz SRR25743026.fastq.gz SRR25743027.fastq.gz
do
SRR=`echo $i|sed 's/\.fastq.gz//g'`
/media/kalki/CXCL16_revision/minimap2-2.28_x64-linux/minimap2 -t 16 -ax map-pb pilon_SRR25743026.493011-SRR12540953_SRR14517642_SRR14839290.fasta $i | /home/kalki/software/samtools-1.21/samtools sort -@ 16 -O BAM - > "$SRR".minimap2.bam
samtools index "$SRR".minimap2.bam
done
samtools merge -@ 8 SRR25743018_SRR25743022-6.bam *.minimap2.bam
samtools sort SRR25743018_SRR25743022-6.bam -@ 8 -o SRR25743018_SRR25743022-6.sorted.bam
samtools index SRR25743018_SRR25743022-6.sorted.bam

makeblastdb -in pilon_SRR25743026.493011-SRR12540953_SRR14517642_SRR14839290.fasta -out pilon_SRR25743026.493011-SRR12540953_SRR14517642_SRR14839290.fasta -dbtype nucl
blastn -task blastn -evalue 0.01 -db pilon_SRR25743026.493011-SRR12540953_SRR14517642_SRR14839290.fasta -out blastn.Caretta_caretta_MED11_CXCL16_PRSS55_ZMYND15.fa.pilon_SRR25743026.493011-SRR12540953_SRR14517642_SRR14839290.fasta.bls -num_threads 2 -outfmt 7 -query Caretta_caretta_MED11_CXCL16_PRSS55_ZMYND15.fa
/media/kalki/CXCL16_revision/blast2bed/blast2bed blastn.Caretta_caretta_MED11_CXCL16_PRSS55_ZMYND15.fa.pilon_SRR25743026.493011-SRR12540953_SRR14517642_SRR14839290.fasta.bls
sort -nk2 blastn.Caretta_caretta_MED11_CXCL16_PRSS55_ZMYND15.fa.pilon_SRR25743026.493011-SRR12540953_SRR14517642_SRR14839290.fasta.bed|grep -v "#" > blastn.Caretta_caretta_MED11_CXCL16_PRSS55_ZMYND15.fa.pilon_SRR25743026.493011-SRR12540953_SRR14517642_SRR14839290.fasta.sorted.bed
 
#klumpy for region:
for i in `ls *.gz|sed 's/\.fastq.gz//g'`
do
grep "$i" MED11-CXCL16-ZMYND15.sorted.lst > "$i".sorted.lst
seqtk subseq "$i".fastq.gz "$i".sorted.lst >> MED11-CXCL16-ZMYND15.sorted.fq
echo $i
done
klumpy find_klumps --subject pilon_SRR25743026.493011-SRR12540953_SRR14517642_SRR14839290.fasta --query MED11-CXCL16-ZMYND15.sorted.fq
klumpy find_gaps --fasta pilon_SRR25743026.493011-SRR12540953_SRR14517642_SRR14839290.fasta
#output Did not find any gaps in pilon_SRR25743026.493011-SRR12540953_SRR14517642_SRR14839290.fasta
klumpy klump_plot --klumps_tsv pilon_SRR25743026.493011-SRR12540953_SRR14517642_SRR14839290_klumps.tsv --format png --seq_name SRR25743026.493011_pilon --leftbound 1 --rightbound 48485 --vertical_line_gaps --vertical_line_klumps

/media/kalki/CXCL16_revision/minimap2-2.28_x64-linux/minimap2 -t 16 -ax map-pb pilon_SRR25743026.493011-SRR12540953_SRR14517642_SRR14839290.fasta MED11-CXCL16-ZMYND15.sorted.fq | /home/kalki/software/samtools-1.21/samtools sort -@ 16 -O BAM - > MED11-CXCL16-ZMYND15.sorted.minimap2.bam
samtools index MED11-CXCL16-ZMYND15.sorted.minimap2.bam
klumpy scan_alignments --alignment_map MED11-CXCL16-ZMYND15.sorted.minimap2.bam --threads 16 --window_size 10000
klumpy alignment_plot --alignment_map MED11-CXCL16-ZMYND15.sorted.minimap2.bam --reference SRR25743026.493011_pilon --candidates MED11-CXCL16-ZMYND15.sorted.minimap2_Candidate_Regions.tsv --min_len 5000 --window_size 10000 --window_step 5000 --color red --vertical_line_gaps --vertical_line_klumps --format png --deletion_len 1 --leftbound 1 --rightbound 48485


##igv report
create_report Phalacrocorax_carbo_ELP5-ARRB2.bed --standalone --fasta Phalacrocorax_carbo_chr34.fa --tracks /home/bbgs/CXCL16_revision/chain_toga/mapping/ERR12353019-20.PacBiohifi.merge.sorted.bam ERR12353019-20.PacBiohifi.subseted.5kb.bed /home/bbgs/CXCL16_revision/chain_toga/mapping/SRR959560-61.Illumina.merge.sorted.bam /home/bbgs/CXCL16_revision/chain_toga/mapping/RNA/ERR12356292_Aligned.sortedByCoord.out.bam /home/bbgs/CXCL16_revision/chain_toga/mapping/RNA/SRR10852993_Aligned.sortedByCoord.out.bam Phalacrocorax_carbo_chr34.gtf /home/bbgs/CXCL16_revision/chain_toga/mapping/blastn.Phalacrocorax_carbo_CXCL16_locus_cds.Phalacrocorax_carbo_chr34.sorted.bed --output Phalacrocorax_carbo_ELP5-to-ARRB2_IGV --info-columns Chromosome Start_position End_position --translate-sequence-track

