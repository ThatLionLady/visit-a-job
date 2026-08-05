
# find reference genomes on NCBI (see github for instructions)

# activate conda environment 
conda activate visit-a-job

# download all the genomes you want to compare
datasets download genome accession ${GENOME_GENBANK_NUMBER} --include genome

# calculate synteny (similarities) between a list of reference genomes with an allowed divergence of 5%
ntSynt --fastas_list References.list -d 5

# write path of all .fai files in the directory to an fais.txt file to be used in ntsynt_viz
find . -name "*.fai" -printf "%f\n" > fais.txt

# Visualize Synteny
# REQUIREMENTS: 
#	- ntSynt.k24.w1000.synteny_blocks.tsv [output from ntSynt]
#	- fais.txt
#	- NameConversion.tsv [tab-separated file with genome filename and the name you want on the final plot]

# FYI: MP only within conda environment
ntsynt_viz.py --blocks ntSynt.k24.w1000.synteny_blocks.tsv --fais fais.txt --format pdf --name_conversion NameConversion.tsv --normalize --target-genome $FAVORITE_SPECIES

# if plotting is the only part that didn't work (MP)
Rscript /home/ubuntu/USS/caitlin/Programs/ntSynt-viz-1.0.0/bin/ntsynt_viz_plot_synteny_blocks_ribbon_plot.R -s ntSynt-viz_ribbon-plot.sequence_lengths.sorted.tsv -l ntSynt-viz_ribbon-plot.links.tsv -c ntSynt-viz_ribbon-plot.chrom-paint-feats.tsv --tree ntSynt-viz_ribbon-plot_est-distances.nwk --order ntSynt-viz_ribbon-plot_est-distances.order.tsv --format pdf --height 20 --width 50 --ratio 0.1 -p ntSynt-viz_ribbon-plot_ribbon-plot
