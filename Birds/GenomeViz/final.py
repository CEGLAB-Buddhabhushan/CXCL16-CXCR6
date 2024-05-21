from pygenomeviz import GenomeViz
exon_CXCR6 = [(5944, 6981)]
exon_FYCO1_Exon14_15 = [(1000, 1144), (15438, 15532)]

gv = GenomeViz()
track = gv.add_feature_track(name=f"Gene Features", size=16532)
track.add_exon_feature(exon_CXCR6, strand=1, plotstyle="arrow", label="CXCR6", labelrotation=0, labelha="center", facecolor="red")

exon_labels = [f"exon{15-i}" for i in  range(len(exon_FYCO1_Exon14_15))]
track.add_exon_feature(exon_FYCO1_Exon14_15, strand=-1, plotstyle="bigrbox", label="FYCO1_Intron", labelrotation=0, labelvpos="bottom", labelha="center", facecolor="lime", edgecolor="red", linewidth=3, exon_labels=exon_labels, exon_label_kws={"y": 0, "va": "center", "color": "blue"})



genome_list = (
    {"name": "Anas_platyrhynchos", "size": 16532, "cds_list": ((1000, 1144, -1), (15438, 15532, -1), (5944, 6981, 1))},
    {"name": "Gallus_gallus", "size": 6099, "cds_list": ((1000, 1144, -1), (5005, 5099, -1))},
    {"name": "Anser_cygnoides", "size": 18058, "cds_list": ((1000, 1144, -1), (16964, 17058, -1), (6240, 7277, 1))},
    {"name": "Meleagris_gallopavo", "size": 6288, "cds_list": ((1000, 1144, -1), (5194, 5288, -1))}
)


#gv = GenomeViz(tick_style="axis")
for genome in genome_list:
    name, size, cds_list = genome["name"], genome["size"], genome["cds_list"]
    track = gv.add_feature_track(name, size)
    for idx, cds in enumerate(cds_list, 1):
        start, end, strand = cds
        track.add_feature(start, end, strand, plotstyle="bigbox", labelrotation=0, labelha="center", linewidth=3)

# Add links between "Anas platyrhynchos" and "Gallus gallus"
gv.add_link(("Anas_platyrhynchos", 14304, 15689), ("Gallus_gallus", 3841, 5253))
gv.add_link(("Anas_platyrhynchos", 870, 1567), ("Gallus_gallus", 874, 1555))
gv.add_link(("Anas_platyrhynchos", 290, 807), ("Gallus_gallus", 358, 872))
gv.add_link(("Anas_platyrhynchos", 12640, 13619), ("Gallus_gallus", 1845, 2801))
gv.add_link(("Anas_platyrhynchos", 1774, 2037), ("Gallus_gallus", 1591, 1840))
gv.add_link(("Anas_platyrhynchos", 13649, 13935), ("Gallus_gallus", 3284, 3589))
gv.add_link(("Anas_platyrhynchos", 15696, 15818), ("Gallus_gallus", 5988, 6098))

# Add links between "Gallus_gallus" and "Anser_cygnoides"
gv.add_link(("Gallus_gallus", 3632, 6048), ("Anser_cygnoides", 15644, 18053))
gv.add_link(("Gallus_gallus", 872, 1485), ("Anser_cygnoides", 866, 1502))
gv.add_link(("Gallus_gallus", 358, 835), ("Anser_cygnoides", 285, 765))
gv.add_link(("Gallus_gallus", 1833, 2801), ("Anser_cygnoides", 13875, 14840))
gv.add_link(("Gallus_gallus", 3281, 3589), ("Anser_cygnoides", 14867, 15176))
gv.add_link(("Gallus_gallus", 1591, 1840), ("Anser_cygnoides", 1770, 1991))
# Add links between "Anser_cygnoides" and "Meleagris_gallopavo"
gv.add_link(("Anser_cygnoides", 15644, 18040), ("Meleagris_gallopavo", 3825, 6219))
gv.add_link(("Anser_cygnoides", 323, 1991), ("Meleagris_gallopavo", 332, 2061))
gv.add_link(("Anser_cygnoides", 13875, 14840), ("Meleagris_gallopavo", 2054, 3001))
gv.add_link(("Anser_cygnoides", 14837, 15174), ("Meleagris_gallopavo", 3446, 3784))


gv.savefig("Final.png")
