cdskit accession2fasta --accession_file ncbi_acc_no.lst -o output.fasta
cdskit mask --seqfile input.fasta --outfile output.fasta
cut -f1,2 -d'_' output.fasta> Primates.fa
seqtk subseq ../Human.nucleotide.fasta TOGA.lst |sed 's/-//g'>>Primates.fa
grep ">" Primates.fa|sed 's/>//g' > Primates.lst

for i in `ls -d */`; do cat $i/errors.log; echo $i; done
for i in `cat list_of_genomes` ; do genome=`cat $i/list_genome`; echo -e "$i\t$genome" ; done
for i in `cat Artiodactyla.list_of_genomes`; do grep "$i" Human.orthology.loss_summ.tsv; done
