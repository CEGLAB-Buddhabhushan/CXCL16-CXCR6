from pymsaviz import MsaViz

mv = MsaViz("output.faTrans.aln.fasta", wrap_length=100, show_consensus=False, color_scheme="None")

# Add text annotations
mv.add_text_annotation((1, 44), "N-terminus", text_color="red", range_color="black")
mv.add_text_annotation((45, 71), "TM1", text_color="red", range_color="red")
mv.add_text_annotation((72, 80), "ICL1", text_color="red", range_color="black")
mv.add_text_annotation((81, 101), "TM2", text_color="red", range_color="red")
mv.add_text_annotation((102, 115), "ECL1", text_color="red", range_color="black")
mv.add_text_annotation((116, 137), "TM3", text_color="red", range_color="red")
mv.add_text_annotation((138, 155), "ICL2", text_color="red", range_color="black")
mv.add_text_annotation((156, 176), "TM4", text_color="red", range_color="red")
mv.add_text_annotation((177, 203), "ECL2", text_color="red", range_color="black")
mv.add_text_annotation((204, 231), "TM5", text_color="red", range_color="red")
mv.add_text_annotation((232, 247), "ICL3", text_color="red", range_color="black")
mv.add_text_annotation((248, 275), "TM6", text_color="red", range_color="red")
mv.add_text_annotation((276, 291), "ECL3", text_color="red", range_color="black")
mv.add_text_annotation((292, 309), "TM7", text_color="red", range_color="red")
mv.add_text_annotation((310, 359), "C-terminus", text_color="red", range_color="black")
mv.savefig("VERTEBRATE.png")
