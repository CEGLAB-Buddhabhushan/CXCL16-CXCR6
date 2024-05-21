
faTrans -stop Primates.fa Primates.AA.fa
awk '/^>/ { file=substr($1,2) ".fasta" } { print > file }' Primates.AA.fa
for clade in Afrotheria Amphibia Artiodactyla Aves Carnivora Chiroptera Eulipotyphla Lagomorpha Metatheria Monotremata Perissodactyla Pholidota Primates Rodentia Sphenodon_punctatus Squamata Testudines Xenarthra
do
for i in All_INPUTs/$clade/*.fasta
do
./static/predictor/precogx.py all --file $i
done
cd static/predictor/output/
mkdir precogx_output_"$clade"
mv * precogx_output_"$clade"
cd precogx_output_"$clade"
for i in `ls -1`
do
sp=`cat $i/out.tsv |grep "WT"|cut -f1`
cp $i/out.tsv "$sp"_precogx.output
echo $sp
done
for i in `ls *_precogx.output|sed 's/_precogx.output//g'`
do
grep "WT" "$i"_precogx.output >> precogx.output
echo $i
done
sed -i "s/WT/$clade/g" precogx.output
cd ..
mv precogx_output_"$clade" /home/buddha/software/precogx/All_INPUTs/$clade/
cd /home/buddha/software/precogx
cat All_INPUTs/$clade/precogx_output_"$clade"/precogx.output >> All_INPUTs/All_INPUTs_precogx_output.tsv
done
