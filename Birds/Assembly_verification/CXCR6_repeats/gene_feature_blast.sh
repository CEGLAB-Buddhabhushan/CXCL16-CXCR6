for i in Anas_platyrhynchos_chr2.fa Gallus_gallus_chr2.fa Taeniopygia_guttata_chr2.fa
do
makeblastdb -in $i -out $i -dbtype nucl
blastn -task blastn -evalue 0.05 -db $i -out blastn.Struthio_camelus_gene_features."$i".bls -num_threads 8 -outfmt 7 -query Struthio_camelus_gene_features.fa
blast2bed blastn.Struthio_camelus_gene_features."$i".bls
done

