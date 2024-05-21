faSplit byname C-term.fa C-term_split_files/
for i in *.fa; do sp=`echo $i|sed 's/\.fa//g'`; pepinfo -sequence $i -graph png -outfile "$sp".pepinfo -hwindow 5; mv pepinfo.1.png "$sp".pepinfo.1.png; mv pepinfo.2.png "$sp".pepinfo.2.png; done

for i in *.fa; do sp=`echo $i|sed 's/\.fa//g'`; pepstats -sequence $i -outfile "$sp".pepstats; done


echo -e "species Residues Charge Tiny Small Aliphatic Aromatic Non_polar Polar Charged Basic Acidic"|sed 's/ /\t/g' > C-term.pepstat.tsv
for i in *.pepstats
do
species=`grep "PEPSTATS of" $i|cut -f3 -d' '|sed 's/ //g'`
Residues=`grep "Residues = " $i|cut -d'=' -f3|sed 's/ //g'`
Charge=`grep "Charge   = " $i|cut -d'=' -f3|sed 's/ //g'`
Tiny=`grep "Tiny" $i |sed 's/\t\+/\t/g'|cut -f3|sed 's/ //g'`
Small=`grep "Small" $i |sed 's/\t\+/\t/g'|cut -f3|sed 's/ //g'`
Aliphatic=`grep "Aliphatic" $i |sed 's/\t\+/\t/g'|cut -f3|sed 's/ //g'`
Aromatic=`grep "Aromatic" $i |sed 's/\t\+/\t/g'|cut -f3|sed 's/ //g'`
Non_polar=`grep "Non-polar" $i |sed 's/\t\+/\t/g'|cut -f3|sed 's/ //g'`
Polar=`grep "Polar" $i |sed 's/\t\+/\t/g'|cut -f3|sed 's/ //g'`
Charged=`grep "Charged" $i |sed 's/\t\+/\t/g'|cut -f3|sed 's/ //g'`
Basic=`grep "Basic" $i |sed 's/\t\+/\t/g'|cut -f3|sed 's/ //g'`
Acidic=`grep "Acidic" $i |sed 's/\t\+/\t/g'|cut -f3|sed 's/ //g'`


echo -e "$species $Residues $Charge $Tiny $Small $Aliphatic $Aromatic $Non_polar $Polar $Charged $Basic $Acidic"|sed 's/ /\t/g'  >> C-term.pepstat.tsv

done
