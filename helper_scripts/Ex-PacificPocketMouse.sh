# Download genomes (Pacific pocket mouse and friends)
## TARGET: Perognathus longimembris pacificus (Pacific pocket mouse)
datasets download genome accession GCA_023159225.1 --include genome

# Option 1:
## FRIEND 1: Perognathus longimembris (Little pocket mouse) 
datasets download genome accession GCA_024363575.2 --include genome
## FRIEND 2: Dipodomys merriami (Merriam's kangaroo rat)
datasets download genome accession GCA_024711535.1 --include genome
## FRIEND 3: Dipodomys spectabilis (banner-tailed kangaroo rat)
datasets download genome accession GCA_019054845.1 --include genome
## FRIEND 4: Dipodomys stephensi (Stephens's kangaroo rat) ---> This one has LOTS of scaffolds. That's a red flag for later!
# >> datasets download genome accession GCA_004024685.1 --include genome
## FRIEND 5: Dipodomys ordii (Ord's kangaroo rat)
datasets download genome accession GCA_000151885.2 --include genome

## Extra Friend: Castor canadensis (American beaver)
datasets download genome accession GCA_047511655.2  --include genome

# Option 2:
## Download all of Heteromyidae <- downloads GCF instead of GCA
datasets download genome taxon Heteromyidae --reference --include genome

# TARGET + FRIEND 1 = 1 hour 11 min (HD)
# TARGET + FRIEND 3 & 4 = 2 hours 11 min (TT)
# TARGET + FRIEND 2 & 3 & EXTRA = 

# Make References List
find . -name "*.fna" -printf "%f\n" > References.list

# Make name conversion file (follow instructions)
bash make-name-conversion.sh References.list

# Mash to FastMe Option
# Mash Sketch (took ~8 minutes for all)
mash sketch *.fna

# Mash Distance
mash triangle *.msh > mash_distances.tsv

# Relabel Mash Tree
cp mash_distances.tsv distances.tsv && while read FULL SHORT; do sed -i "s/${FULL}/${SHORT}/g" distances.tsv; done < NameConversion.tsv

# Convert Triangle to Phylip
python mash_to_fastme.py distances.tsv mash_fastme.phy

# Make Tree
fastme -i mash_fastme.phy -o mash_tree.nwk

# Visualize Tree
nw_display mash_tree.nwk

# Run ntSynt
ntSynt --fastas_list References.list -d 12

# Index FASTAs, if not already indexed (is this needed or does ntSynt index???)
for fasta in *.fna; do samtools faidx "$fasta"; done

# Make FAIS List
find . -name "*.fai" -printf "%f\n" > fais.txt

# Plot Synteny
# With tree (4+)
ntsynt_viz.py --blocks ntSynt.k24.w1000.synteny_blocks.tsv --fais fais.txt --format pdf --name_conversion NameConversion.tsv --normalize --tree mash_tree.nwk --target-genome PPM

# Without tree (2-3)
ntsynt_viz.py --blocks ntSynt.k24.w1000.synteny_blocks.tsv --fais fais.txt --format pdf --name_conversion NameConversion.tsv --normalize --target-genome PPM --length 0 --seq_length 0
