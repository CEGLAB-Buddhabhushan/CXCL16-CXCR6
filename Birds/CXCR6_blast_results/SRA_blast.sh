cd /home/neo/bird_db1
for i in `cat Birds_SRA.lst`
do
cd $i
echo $i
SRA_db=`ls *.nal|sed 's/\.nal//g'`

species_name=`echo $i`

CXCR6="/home/neo/bird_db1/buddha/CXCR6/query/Struthio_camelus_Exon.fa"

blastn -task blastn -evalue 0.05 -max_target_seqs 5000 -db $SRA_db -out /home/neo/bird_db1/buddha/CXCR6/blast_output_SRA/blastn.Struthio_camelus_CXCR6."$species_name".SRA.anseriformes.sam -num_threads 4 -outfmt "17 SQ" -query $CXCR6
blastn -task blastn -evalue 0.05 -max_target_seqs 5000 -db $SRA_db -out /home/neo/bird_db1/buddha/CXCR6/blast_output_SRA/blastn.Struthio_camelus_CXCR6."$species_name".SRA.anseriformes.4out -num_threads 4 -outfmt 4 -query $CXCR6
blastn -task blastn -evalue 0.05 -max_target_seqs 5000 -db $SRA_db -out /home/neo/bird_db1/buddha/CXCR6/blast_output_SRA/blastn.Struthio_camelus_CXCR6."$species_name".SRA.anseriformes.1out -num_threads 4 -outfmt 1 -query $CXCR6
blastn -task blastn -evalue 0.05 -max_target_seqs 5000 -db $SRA_db -out /home/neo/bird_db1/buddha/CXCR6/blast_output_SRA/blastn.Struthio_camelus_CXCR6."$species_name".SRA.mview.out -num_threads 4 -outfmt "7 std qseq sseq stitle" -query $CXCR6

echo -e $species_name"\t"$SRA_db
echo -e $species_name"\t"$SRA_db >> /home/neo/bird_db1/buddha/CXCR6/SRA_blast.tsv
cd ..
done

cd /media/neo/5e4dad81-4707-4b68-ac02-d35a20881d06/home/ceglab26/sagar/bird_database
for i in `cat Birds_SRA.lst`
do
cd $i
echo $i
SRA_db=`ls *.nal|sed 's/\.nal//g'`

species_name=`echo $i`


CXCR6="/home/neo/bird_db1/buddha/CXCR6/query/Struthio_camelus_Exon.fa"

blastn -task blastn -evalue 0.05 -max_target_seqs 5000 -db $SRA_db -out /home/neo/bird_db1/buddha/CXCR6/blast_output_SRA/blastn.Struthio_camelus_CXCR6."$species_name".SRA.anseriformes.sam -num_threads 4 -outfmt "17 SQ" -query $CXCR6
blastn -task blastn -evalue 0.05 -max_target_seqs 5000 -db $SRA_db -out /home/neo/bird_db1/buddha/CXCR6/blast_output_SRA/blastn.Struthio_camelus_CXCR6."$species_name".SRA.anseriformes.4out -num_threads 4 -outfmt 4 -query $CXCR6
blastn -task blastn -evalue 0.05 -max_target_seqs 5000 -db $SRA_db -out /home/neo/bird_db1/buddha/CXCR6/blast_output_SRA/blastn.Struthio_camelus_CXCR6."$species_name".SRA.anseriformes.1out -num_threads 4 -outfmt 1 -query $CXCR6
blastn -task blastn -evalue 0.05 -max_target_seqs 5000 -db $SRA_db -out /home/neo/bird_db1/buddha/CXCR6/blast_output_SRA/blastn.Struthio_camelus_CXCR6."$species_name".SRA.mview.out -num_threads 4 -outfmt "7 std qseq sseq stitle" -query $CXCR6
echo -e $species_name"\t"$SRA_db
echo -e $species_name"\t"$SRA_db >> /home/neo/bird_db1/buddha/CXCR6/SRA_blast.tsv
cd ..
done

cd /media/neo/5e4dad81-4707-4b68-ac02-d35a20881d06/home/ceglab26/sagar/bird_database/galliforms_database
for i in `cat list_galliformes_25_in_bird_database_galliforms_database_SRA|sort -u`
do
cd $i
echo $i
SRA_db=`ls *.nal|sed 's/\.nal//g'`

species_name=`echo $i`


CXCR6="/home/neo/bird_db1/buddha/CXCR6/query/Struthio_camelus_Exon.fa"

blastn -task blastn -evalue 0.05 -max_target_seqs 5000 -db $SRA_db -out /home/neo/bird_db1/buddha/CXCR6/blast_output_SRA/blastn.Struthio_camelus_CXCR6."$species_name".SRA.anseriformes.sam -num_threads 4 -outfmt "17 SQ" -query $CXCR6
blastn -task blastn -evalue 0.05 -max_target_seqs 5000 -db $SRA_db -out /home/neo/bird_db1/buddha/CXCR6/blast_output_SRA/blastn.Struthio_camelus_CXCR6."$species_name".SRA.anseriformes.4out -num_threads 4 -outfmt 4 -query $CXCR6
blastn -task blastn -evalue 0.05 -max_target_seqs 5000 -db $SRA_db -out /home/neo/bird_db1/buddha/CXCR6/blast_output_SRA/blastn.Struthio_camelus_CXCR6."$species_name".SRA.anseriformes.1out -num_threads 4 -outfmt 1 -query $CXCR6
blastn -task blastn -evalue 0.05 -max_target_seqs 5000 -db $SRA_db -out /home/neo/bird_db1/buddha/CXCR6/blast_output_SRA/blastn.Struthio_camelus_CXCR6."$species_name".SRA.mview.out -num_threads 4 -outfmt "7 std qseq sseq stitle" -query $CXCR6
echo -e $species_name"\t"$SRA_db
echo -e $species_name"\t"$SRA_db >> /home/neo/bird_db1/buddha/CXCR6/SRA_blast.tsv
cd ..
done

