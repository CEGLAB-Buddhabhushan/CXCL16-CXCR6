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
