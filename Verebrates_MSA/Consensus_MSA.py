from pymsaviz import MsaViz

mv = MsaViz("output.faTrans.aln.fasta", wrap_length=100, show_consensus=True, color_scheme="Clustal")

# Extract MSA positions less than 50% consensus identity

pos_ident_less_than_50 = []
ident_list = mv._get_consensus_identity_list()
for pos, ident in enumerate(ident_list, 1):
    if ident <= 50:
        pos_ident_less_than_50.append(pos) 
mv.add_markers(pos_ident_less_than_50, marker="x", color="red")

cons_ident_more_than_50 = []
ident_list = mv._get_consensus_identity_list()
for cons, ident in enumerate(ident_list, 1):
    if ident > 50:
        cons_ident_more_than_50.append(cons)
mv.add_markers(cons_ident_more_than_50, marker="*", color="green")
mv.savefig("Consensus_VERTEBRATE.png")
