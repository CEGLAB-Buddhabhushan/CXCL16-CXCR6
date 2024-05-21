##alignment
guidance=/home/ceglab358/BUDDHA/Tools/guidance.v2.02/www/Guidance/guidance.pl
for i in `ls "$clade".fa`
do
j=`echo $i|sed 's/.fa//g'`
perl $guidance --program GUIDANCE --seqFile "$i" --msaProgram PRANK --seqType codon --outDir "$i".100_PRANK --genCode 1 --bootstraps 100 --proc_num 16
cp "$i".100_PRANK/MSA.PRANK.aln.With_Names "$j".aln
rm -r "$i".100_PRANK
done
##trimal
trimal -in CXCR6_ORF.aln -out CXCR6_ORF_trimal.aln -automated1

##modeltest-ng and Raxml-ng
for aln in  CXCR6_ORF.aln CXCR6_ORF_trimal.aln
do
i=`echo $aln|sed 's/\.aln//g'`
modeltest-ng -i $aln -o "$i"modeltest

model=$(awk '{if($1=="BIC"){print $2}}' *log| tail -1)
echo $model
mkdir "$i"_modeltest_out 
mv "$i"modeltest* "$i"_modeltest_out 

raxml-ng --all --msa $aln --model $model --bs-trees 1000 --threads 4 --prefix boot 

raxml-ng --consense MR --tree boot.raxml.bootstraps --prefix cons
mv boot* cons* "$i"_modeltest_out 
done
##iq-tree
/home/ceglab358/BUDDHA/Tools/iqtree-2.2.2.6-Linux/bin/iqtree2  -s CXCR6_ORF.aln
/home/ceglab358/BUDDHA/Tools/iqtree-2.2.2.6-Linux/bin/iqtree2  -s CXCR6_ORF_trimal.aln


#########################################################################
clade=$1
# to remove internode labels from the TimeTree nwk file
for i in "$clade".nwk
do
sed -e "s/'[^()]*'//g" $i > temp.nwk
mv temp.nwk $i
done

# This script check whether the species name in the fasta file and nwk file are same or not.
for i in "$clade".fa
do
grep ">" $i|sed 's/>//g' > $i.txt
j="$clade".nwk
sed 's/(/\n/g' $j|sed 's/)/\n/g' |sed 's/;/\n/g' |sed 's/:/\n/g' |sed 's/,/\n/g' |grep "^[A-Z]" > $j.txt
echo $j
cat $i.txt $j.txt |sort|uniq -c |awk '$1<2 {print $2}'
rm *.txt
done
guidance=/home/ceglab358/BUDDHA/Tools/guidance.v2.02/www/Guidance/guidance.pl
for i in `ls "$clade".fa`
do
j=`echo $i|sed 's/.fa//g'`
perl $guidance --program GUIDANCE --seqFile "$i" --msaProgram CLUSTALW --seqType codon --outDir "$i".100_CLUSTALW --genCode 1 --bootstraps 100 --proc_num 16
cp "$i".100_CLUSTALW/MSA.CLUSTALW.aln.With_Names "$j".aln
rm -r "$i".100_CLUSTALW
done
##alignment in MegaX clustalW

##trimal
trimal -in CXCR6_ORF_MegaX_NT.fas -out CXCR6_ORF_MegaX_NT_trimal.aln -automated1
cut -f1 -d' ' CXCR6_ORF_MegaX_NT_trimal.aln > CXCR6_ORF_MegaX_NT_trimal.CSUBST.aln

##gene TREE
for aln in CXCR6_ORF_MegaX_NT_trimal.CSUBST.aln
do
i=`echo $aln|sed 's/\.aln//g'`
modeltest-ng -i $aln -o "$i"modeltest

model=$(awk '{if($1=="BIC"){print $2}}' *log| tail -1)
echo $model
mkdir "$i"_modeltest_out 
mv "$i"modeltest* "$i"_modeltest_out 

raxml-ng --all --msa $aln --model $model --bs-trees 1000 --threads 8 --prefix boot 
raxml-ng --support --tree boot.raxml.bestTree --bs-trees boot.raxml.bootstraps
mv boot* "$i"_modeltest_out 
done

for i in `ls -d */`
do
cd $i
csubst analyze --alignment_file ../CXCR6_ORF.trimal.CSUBST.aln --rooted_tree_file ../CXCR6_ORF.nwk --foreground fg_*.txt
cd ../
done

transeq \
-sequence CXCR6_ORF.fa \
-outseq CXCR6_ORF.AA.fa \
-frame 1 \
-table 0

mafft \
--auto \
--amino \
CXCR6_ORF.AA.fa \
> CXCR6_ORF.AA.fa.aln

tranalign \
-table 0 \
-asequence CXCR6_ORF.fa \
-bsequence CXCR6_ORF.AA.fa.aln \
-outseq CXCR6_ORF.CDS.fa.aln


cdskit hammer \
--seqfile CXCR6_ORF.CDS.fa.aln \
--outfile CXCR6_ORF.CDS.fa.aln.trimmed.fasta.fa \
--codontable 1 \
--nail 4

clade=CXCR6_ORF.CDS.fa.aln.trimmed.fasta
# to remove internode labels from the TimeTree nwk file
for i in "$clade".nwk
do
sed -e "s/'[^()]*'//g" $i > temp.nwk
mv temp.nwk $i
done

# This script check whether the species name in the fasta file and nwk file are same or not.
for i in "$clade".fa
do
grep ">" $i|sed 's/>//g' > $i.txt
j="$clade".nwk
sed 's/(/\n/g' $j|sed 's/)/\n/g' |sed 's/;/\n/g' |sed 's/:/\n/g' |sed 's/,/\n/g' |grep "^[A-Z]" > $j.txt
echo $j
cat $i.txt $j.txt |sort|uniq -c |awk '$1<2 {print $2}'
rm *.txt
done

for i in fg_*
do
echo $i
cd $i
csubst analyze --alignment_file CXCR6.CDS.trimmed.fasta --rooted_tree_file CXCR6.nwk --foreground fg_*.txt --threads 4
cd ..
done
csubst analyze --alignment_file CXCR6.CDS.trimmed.fasta --rooted_tree_file CXCR6.nwk --foreground fg_*.txt --threads 4
target_branch=`cat csubst_target_branch.txt|tr '\n' ','|cut -f1-2 -d','`
csubst site --alignment_file CXCR6.CDS.trimmed.fasta --rooted_tree_file CXCR6.nwk --branch_id  $target_branch --pdb /home/ceglab358/BUDDHA/CXCR6/gene_tree_CXCR6/CSUBST/combinations/CSUBST_input/AF-O00574-F1-model_v4.pdb

csubst analyze --alignment_file CXCR6.CDS.trimmed.fasta --rooted_tree_file CXCR6.nwk --foreground fg_*.txt --fg_exclude_wg no --fg_stem_only no --cutoff_stat 'OCNany2spe,3.0|omegaCany2spe,3.0' 

csubst analyze --alignment_file CXCR6.CDS.trimmed.fasta --rooted_tree_file CXCR6.nwk --foreground fg_*.txt --max_arity 10 --exhaustive_until 3 --threads 4

csubst analyze --alignment_file CXCR6.CDS.trimmed.fasta --rooted_tree_file CXCR6.nwk --foreground fg_*.txt --max_arity 10 --exhaustive_until 3 --threads 4
csubst site --alignment_file CXCR6.CDS.trimmed.fasta --rooted_tree_file CXCR6.nwk --branch_id 20,46,55 --pdb /home/ceglab358/BUDDHA/CXCR6/comparison/RMSD/AF-O00574-F1-model_v4.pdb

##for K=2
for i in fg_Amphibia-Mammalia fg_G.Seraphini-Squamata fg_S.punctatus-Aves fg_Testudines-Mammalia
do
cd $i
csubst analyze --alignment_file CXCR6.CDS.trimmed.fasta --rooted_tree_file CXCR6.nwk --foreground fg_*.txt --threads 4
target_branch=`cat csubst_target_branch.txt|tr '\n' ','|cut -f1-2 -d','`
csubst site --alignment_file CXCR6.CDS.trimmed.fasta --rooted_tree_file CXCR6.nwk --branch_id  $target_branch --pdb /home/ceglab358/BUDDHA/CXCR6/gene_tree_CXCR6/CSUBST/combinations/CSUBST_input/AF-O00574-F1-model_v4.pdb
cd ..
done

##for K=3
cd fg_Amphibia-Testudines-Mammalia

csubst analyze --alignment_file CXCR6.CDS.trimmed.fasta --rooted_tree_file CXCR6.nwk --foreground fg_*.txt --threads 4 --max_arity 3
##target_branch are 20,46,55
csubst site --alignment_file CXCR6.CDS.trimmed.fasta --rooted_tree_file CXCR6.nwk --branch_id 20,46 --pdb /home/ceglab358/BUDDHA/CXCR6/gene_tree_CXCR6/CSUBST/combinations/CSUBST_input/AF-O00574-F1-model_v4.pdb
csubst site --alignment_file CXCR6.CDS.trimmed.fasta --rooted_tree_file CXCR6.nwk --branch_id 20,55 --pdb /home/ceglab358/BUDDHA/CXCR6/gene_tree_CXCR6/CSUBST/combinations/CSUBST_input/AF-O00574-F1-model_v4.pdb
csubst site --alignment_file CXCR6.CDS.trimmed.fasta --rooted_tree_file CXCR6.nwk --branch_id 46,55 --pdb /home/ceglab358/BUDDHA/CXCR6/gene_tree_CXCR6/CSUBST/combinations/CSUBST_input/AF-O00574-F1-model_v4.pdb
cd ..




for i in `ls -d */`
do
sp=`echo $i|sed 's/[/]//g'`
for j in `cat "$sp.lst"`
do
echo -e "1\t$j" >> $i/foreground.txt
done
done


csubst analyze --alignment_file alignment.fa --rooted_tree_file tree.nwk --foreground foreground.txt 

csubst site --alignment_file Afrotheria.aln --rooted_tree_file Afrotheria.nwk --branch_id 12,9 --pdb /home/ceglab358/BUDDHA/CXCR6/comparison/RMSD/AF-O00574-F1-model_v4.pdb


for i in fg_*
do
csubst analyze --alignment_file 30_species.aln --rooted_tree_file 30_species.nwk --foreground $i 
echo $i
done

for i in fg_*
do n=`echo $i|sed 's/\.txt//g'`
mkdir $n
cd $n
csubst analyze --alignment_file 30_species_trimmed.aln --rooted_tree_file 30_species.nwk --foreground $i 
echo $n
cd ..
done

csubst site --alignment_file 30_species.aln --rooted_tree_file 30_species.nwk --branch_id  12,54 --pdb /home/ceglab358/BUDDHA/CXCR6/comparison/RMSD/AF-O00574-F1-model_v4.pdb


for i in `ls -d */`
do
sp=`echo $i|sed 's/[/]//g'`
for j in `cat "$sp.lst"`
do
echo -e "$j" >> $i/foreground.txt
done
done


aln="$clade".aln
tree="$clade".nwk
for i in `cat ../foreground.txt`
do
sed -i "s/$i/$i{fg}/g" $tree
done
/media/morpheus/sagar/BUDDHA/WDR93/WDR93_mol_evo_analysis/hyphy-2.5.50/HYPHYMP fel --alignment $aln --tree  $tree --branches fg --resample 10 >treeoutput_fel
