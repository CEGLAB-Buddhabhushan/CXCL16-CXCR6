for i in *.sorted.tsv
do
query=`echo $i|cut -f1 -d'.'|sed 's/Chicken-//g'`
awk -v var="$query" 'BEGIN {FS="\t"; OFS="\t"} NR==1 {print "Species", $5} NR!=1 && $6==1 {print var, $5}' $i > "$query"_wrt_chicken.tsv
echo $query
done
