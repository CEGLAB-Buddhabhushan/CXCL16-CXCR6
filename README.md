# CXCL16-CXCR6
This GitHub repository contains the data for paper **"Evolutionary diversity of CXCL16-CXCR6:
Convergent Substitutions and Recurrent Gene Loss in Sauropsids".**

Buddhabhushan Girish Salve, Sandhya Sharma, Nagarjun Vijay

Computational Evolutionary Genomics Lab, Department of Biological Sciences, IISER Bhopal, Bhauri,
Madhya Pradesh, India
*Correspondence: nagarjun@iiserb.ac.in

## Graphical abstract
![graphical_abstract](https://github.com/CEGLAB-Buddhabhushan/CXCL16-CXCR6/blob/main/Main_figures/Fig1.jpg)

**Folder Structure**
- **Birds:** Contains the raw files for long read assembly verification, BLASTn results, Circos plot, Galliformes specific deletion, Passeriforme specific deletion, and TOGA output. **(Fig. 5-7)**
- **Crocodilia:** Contains the raw read blastn result for the _CXCR6_ gene in crocodiles, assembly verification, and lineage-specific evolutionary analysis result output files. **(Fig. 5)**
- **CSUBST:** Contains the input and output files of CSUBST (Combinatorial SUBSTitutions ). **(Fig. 3)**
- **CXCR6_clade_wise_mol_evo_analysis:** Selection pressure analysis of _CXCR6_ gene across clades, tested using RELAX, codeML, MEME, FEL, aBSREL, BUSTED, and gBGC. **(Fig. 5, Fig. 7)**
- **Elapidae:** Contains the raw read blastn result for the _CXCR6_ gene in snakes, assembly verification, and lineage-specific evolutionary analysis result output files and TOGA output files. **(Fig. 5)**
- **Main_figures:** Contains the main and abstract figures and the inputs required to get figures like phylogenetic trees from TimeTree and iTOLs. **(Fig. 1-8, supplementary figures)**
- **GC-content:**  Clade wise GC content and G/C strenches. **(Fig. 1)**
- **Gene_Divergence:**  Sequence divergence of _CXCL16_ and _CXCR6_ across the key species form vertebrate lineages (_TNF-α_ and _LAT_ gene, which reported to be missing but later found, used for comparison) **(Fig. 1)**
- **GPCRsignal:** Contains the output files of short MD simulations. **(Fig. 4)**
- **ITGAE:** contains the TOGA output for birds, Chicken gene loss confirmation results, and Expression files.
- **LOW_quality_verification:** Verification of low-quality protein note comment.
- **PRECOGx:** Input and output of PRECOGx, a machine learning predictor of GPCR interactions with G-protein and β-arrestin.
- **Synteny:**  Contains the NCBI synteny images for _CXCR6_ and _CXCL16_. **(Fig. 1)**
- **Transcriptome_analysis:** Contains an IGV screenshot for the _CXCR6_ gene. 
- **Verebrates_MSA:**  Contains the MSA files and region specific screenshot such H3C region and terminal region of _CXCR6_ gene. Also, it contains the output of EMBOSS Pepstats and Pepinfo. **(Fig. 2)**
- **sc-RNA_seq:** Contains the screenshot from SPEED atlas and Seurat scripts for chicken, mallard, and pigeon single-cell RNA seq comparison. **(Fig. 8)**
____________________________________________________________________________________________________________________________________________________
**Prerequisites:**
- CSUBST (v1.4.0)
- TOGA (v1.1.2)
- make_lastz_chains (https://github.com/hillerlab/make_lastz_chains.git)
- PAML (4.9f)
- Pymol (Version 2.3.0)
- EMBOSS Pepstats
- EMBOSS Pepinfo
- EMBOSS Needle
- PRECOGx
- Circos
- BLASTN 2.9.0+
- phastBias(1.6)
- mapnh(1.3.0)
- HYPHY 2.5.48(MP)
- BWA(0.7.17-r1188)
- Samtools (1.3)
- bedtools (v2.26.0)
- ea-utils (https://github.com/ExpressionAnalysis/ea-utils.git)
- seqtk (1.2-r94)
- pyMSAviz (v0.4.2)
- Guidance (v2.02)
- PRANK (v.150803)
- IGV (2.8.13)
- STAR (2.7.0d)
- MegaX
- R (4.1.0)

**R packages:**
- ape (5.5)
- phytools (0.7-90)
- ggplot2 (3.3.5)
- ggrepel (0.9.1)
- cowplot (1.1.1)
- dplyr (1.0.7)
- ggplotify (0.1.0)
- grid (4.1.1)
- gridExtra (2.3)
- reshape2 (1.4.4)
