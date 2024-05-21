from pymsaviz import MsaViz

mv = MsaViz("output.faTrans.aln.fasta", start=130, end=150, wrap_length=60, show_consensus=True, color_scheme="Clustal")



# Add text annotations
mv.add_text_annotation((130, 137), "TM3", text_color="red", range_color="red")
mv.add_text_annotation((138, 150), "ICL2", text_color="red", range_color="black")
mv.savefig("H3C_VERTEBRATE.png")
