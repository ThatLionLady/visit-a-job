# Visit a Job 
## Conservation Genetics

Learn about genomics projects using big data and do some bioinformagic of your own with an activity from the command line. No prior experience in genomics, coding, or bioinformatics is required.

```sh
conda activate visit-a-job 
```

[Conda](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html) is a program that helps manage programs. I have pre-installed all the programs you'll need for this exercise. If you're doing this at home, the programs installed in this conda environment are:

- [ncbi_datasets](https://anaconda.org/channels/conda-forge/packages/ncbi-datasets-cli/overview)
- [ntSynt](https://github.com/BirolLab/ntSynt)



# Activity 1 - Synteny

Synteny = finding the exact same sequence of recipes, in the same order, inside different cookbooks.

- Think of two cookbooks:
    - The Chromosomes are chapters
    - The Genes are the individual recipes
    - Synteny is the pages where the recipes match

>One cookbook has 5 drop cookie recipes for from pages 130-135: Chocolate Chip, Peanut Butter, White Chocolate Macadamia, Double Chocolate Chunk, and Oatmeal Raisin.

>Another cookbook has 5 drop cookie recipes from pages 145-150: Chocolate Chip, Peanut Butter, Coconut Macaroons, Double Chocolate Chunk, and Oatmeal Raisin cookies 

Syntheny is the recipes that are the same, in the same order. So the cookie recipe synteny would look something like this:


Synteny in the whole cookbook focusing on the cookies would look something like this:


With the script below, you will make a synteny plot of your favorite animal and a few of it's close relatives.

## Step 1: Find the reference genome of your favorite animal

1. Go to **https://www.ncbi.nlm.nih.gov/**
2. Put your favorite species (species name or common name should work) in the search bar and click ***Search***
> Image of search bar
3. If there is a reference genome, that will be right at the top!
   - If it doesn't, find a closely related species following the next steps.
> Image of search results with and without a reference
4. Click ***Browse Genomes***
> Image of where to click
5. For the genome with the green checkmark, copy the **GenBank** number. 
   - It should be "GCA" followed by nine numbers + ".1"
> Image of genome page
6. Go to the command line and download the genome.

```sh
datasets download genome accession [GENBANK_NUMBER] --include genome
```

## Step 2: Find some friends to compare your animal to

1. Go back to **https://www.ncbi.nlm.nih.gov/**
2. Go back to this page:
> Image of taxonomy page
3. Click ***Browse Taxonomy***
> Image of where to click
4. Browse a bit. If there's a number in the *Genome* column, there's a genome you can download.
    - Does your species have any close relatives at the subspecies level? 
    - If not, go up one in the lineage.
> Image of lineage.

### Option 1

5. When you find a species you want to compare, click the number and copy the **GenBank** number with the green checkmark. 
6. Go to the command line and download the genome.

```sh
datasets download genome accession [GENBANK_NUMBER] --include genome
```

### Option 2

all on the command line...

