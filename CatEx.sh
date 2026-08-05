# Download genomes (Panthera)

# Option 1:
## TARGET: Panthera leo (Lion)
datasets download genome accession GCA_018350215.1 --include genome
bash unpack_ncbi-datasets.sh 

## FRIEND 1: Panther tigris (Tiger)
datasets download genome accession GCA_018350195.2 --include genome
bash unpack_ncbi-datasets.sh 
## FRIEND 2: Panthera uncia (Snow Leopard)
datasets download genome accession GCA_024711535.1 --include genome
bash unpack_ncbi-datasets.sh 
## FRIEND 3: Panthera onca (Jaguar)
datasets download genome accession GCA_046562875.2 --include genome
bash unpack_ncbi-datasets.sh 
## FRIEND 4: Panthera pardus (Leopard)
datasets download genome accession GCA_024362965.1 --include genome
bash unpack_ncbi-datasets.sh

# Option 2:
## Download all of Panthera <- downloads GCF instead of GCA
datasets download genome taxon Panthera --reference --include genome
bash unpack_ncbi-datasets.sh 
#--> CHECK timestamp of the fastas. 
# If it's IN THE FUTURE (weird ncbi-datasets quirk) use touch *.fna to reset timestamp otherwise ntsynt will fail.

# "Panthera" downloads 5 genomes
# Tiger 	 GCA_018350195.2	GCF_018350195.1
# Lion 		 GCA_018350215.1	GCF_018350215.1
# Jaguar 	 GCA_046562875.2	GCF_046562875.1
# SnoLeopard GCA_023721935.1	GCF_023721935.1
# Leopard	 GCA_024362965.1	GCF_024362965.1

# Make References List
find . -name "*.fna" -printf "%f\n" > References.list

# Make name conversion file (follow instructions)
bash make-name-conversion.sh References.list

# Mash to FastMe Option
# Mash Sketch
mash sketch *.fna

# Mash Distance
mash triangle *.msh > mash_distances.tsv

# Convert Triangle to Phylip
python mash_to_fastme.py mash_distances.tsv mash_fastme.phy

# Make Tree
fastme -i mash_fastme.phy -o mash_tree.nwk

# Relabel Mash Tree
cp mash_tree.nwk tree.nwk && while read FULL SHORT; do sed -i "s/${FULL}/${SHORT}/g" tree.nwk; done < NameConversion.tsv

# Visualize Tree
nw_display mash_tree.nwk

# Run ntSynt (13:28:38 MP - 15:20:28 <-- 1 hour 52 min)
ntSynt --fastas_list References.list -d 1

# Index FASTAs, if not already indexed (if ntSynt didn't index for some reason)
for fasta in *.fna; do samtools faidx "$fasta"; done

# Make FAIS List
find . -name "*.fai" -printf "%f\n" > fais.txt

# Plot Synteny
ntsynt_viz.py --blocks ntSynt.k24.w1000.synteny_blocks.tsv --fais fais.txt --format pdf --name_conversion NameConversion.tsv --normalize --tree tree.nwk --target-genome Lion
