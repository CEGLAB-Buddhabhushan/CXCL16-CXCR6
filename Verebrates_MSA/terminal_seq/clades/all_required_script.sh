#!/bin/bash
#!/bin/bash
input_file=$1
sp=`echo $input_file|sed 's/\.aln//g'`
output_file="$sp"_formatted_output.fa

awk '
    /^>/ {
        organism = gensub(/.*organism=([^]]*).*/, "\\1", "g", $0);
        print ">" organism;
    }
    !/^>/ {
        print $0;
    }
' "$input_file" > "$output_file"
sed -i 's/-//g;s/ /_/g' "$sp"_formatted_output.fa
seqtk seq  "$sp"_formatted_output.fa > tmp.out
mv tmp.out "$sp"_formatted_output.fa
echo "Reformatted headers and saved to $output_file"


for i in `ls Vertebrate_CXCR.fa`
do
j=`echo $i|sed 's/\.fasta//g'`
perl $guidance --program GUIDANCE --seqFile "$i" --msaProgram CLUSTALW  --seqType aa --outDir "$i".100_CLUSTALW --genCode 1 --bootstraps 100 --proc_num 16
cp "$i".100_CLUSTALW/MSA.CLUSTALW.aln.With_Names "$j".aln
rm -r "$i".100_CLUSTALW
done


faSplit byname C-term.fa C-term_split_files/


for i in *.fa; do sp=`echo $i|sed 's/\.fa//g'`; pepstats -sequence $i -outfile "$sp".pepstats; done


echo -e "species Residues Charge Tiny Small Aliphatic Aromatic Non_polar Polar Charged Basic Acidic"|sed 's/ /\t/g' > N-term.pepstat.tsv
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


echo -e "$species $Residues $Charge $Tiny $Small $Aliphatic $Aromatic $Non_polar $Polar $Charged $Basic $Acidic"|sed 's/ /\t/g'  >> N-term.pepstat.tsv

done


# Input file
input_file="N-term.pepstat.tsv"

# Output file
output_file="N-term.pepstat_group.tsv"

# Lists for each group
aves_list="Aves.lst"
amphibia_list="Amphibia.lst"
mammals_list="Mammalia.lst"
testudines_list="Testudines.lst"
lepidosauria_list="Lepidosauria.lst"

# AWK script to add the group column
awk -F'\t' -v aves_list="$aves_list" -v amphibia_list="$amphibia_list" -v mammals_list="$mammals_list" -v testudines_list="$testudines_list" -v lepidosauria_list="$lepidosauria_list" '
    BEGIN {
        # Load Aves list into an array
        while ((getline < aves_list) > 0) {
            aves[$1] = 1;
        }
        close(aves_list);

        # Load Amphibia list into an array
        while ((getline < amphibia_list) > 0) {
            amphibia[$1] = 1;
        }
        close(amphibia_list);

        # Load Mammals list into an array
        while ((getline < mammals_list) > 0) {
            mammals[$1] = 1;
        }
        close(mammals_list);

        # Load Testudines list into an array
        while ((getline < testudines_list) > 0) {
            testudines[$1] = 1;
        }
        close(testudines_list);

        # Load Lepidosauria list into an array
        while ((getline < lepidosauria_list) > 0) {
            lepidosauria[$1] = 1;
        }
        close(lepidosauria_list);

        # Print header with the Group column
        print $0 "\tGroup";
    }
    {
        if (NR > 1) {
            # Check which group the species belongs to
            if ($1 in aves) {
                group = "Aves";
            } else if ($1 in amphibia) {
                group = "Amphibia";
            } else if ($1 in mammals) {
                group = "Mammals";
            } else if ($1 in testudines) {
                group = "Testudines";
            } else if ($1 in lepidosauria) {
                group = "Lepidosauria";
            } else {
                group = "Unknown";
            }

            # Print the line with the assigned group
            print $0 "\t" group;
        }
    }
' "$input_file" > "$output_file"

echo "Group column added and saved to $output_file"

