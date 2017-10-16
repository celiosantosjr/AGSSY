# AGSSY
Amazon Gene Catalogue Search System

--------------------------------------------------------------------

**Célio Dias Santos Júnior, Flávio Henrique Silva, Ramiro Logares**

*Colaboration of UFSCar, ICM-CSIC/Es, Petrobrás*

### Brief introduction

Amazon river is a vault of biodiversity and until now no gene catalogue were made holding this. In this gene catalogue you will find the product of the most modern and suittable information about this. It was made using the illumina metagenomics sequences from 106 metagenomes encompassing more than 1500 km of Amazon river, from the upper region (before Manaus city) until coastal Ocean. These sequences were made using the [MEGAHIT](https://github.com/voutcn/megahit) software with complex metagenomes set up to assemblage with a cutoff of 1 Kbp. [Prodigal](http://prodigal.ornl.gov/algorithm.html) was used to predict the genes and a cutoff of 150 bp was used to generate an intermediate database. In order to avoid the incomplete sequences, nucleotide ORFs sequences were then clustered at 95% of identity and the final centroids were translated using transeq. It was obtained ~3,9 million sequences and they were annotated using [KEGG](http://kegg.jp/), [Uniprot](http://uniprot.org/), [DBCAN](http://csbl.bmb.uga.edu/dbCAN/index.php) (analogous to CAZY), [EGGNOG](http://eggnogdb.embl.de/), [COG](https://www.ncbi.nlm.nih.gov/COG/) and [PFAM](http://pfam.xfam.org/) databases. Databases using HMM profiles (DBCAN, EGGNOG, PFAM) were parsed using e-value cutoff of minimum 1e-3 without overlapping. The databases using sequences (Uniprot, KEGG, COG) were annotated using blastp with minimum identity of 45% and e-value of 1e-5. Abundance of each protein is shown as TPM calculated using [eXpress](https://pachterlab.github.io/eXpress/index.html) and is shown per metagenome.

### Installation

To use this system you will need:

- Hmmer package installed in your /usr/bin folder or another known address
- basic linux functions (set up to Ubuntu versions)

The installation procedures are shown bellow:

1. Download the package

2. Decompress it using command: 

```
$ tar -zxvf AM_catalogue-master
```

3. Type the following line: 

```$ sudo apt-get install dialog

$ sudo ln -s /full/path/to/AM_catalogue.sh /usr/local/bin/AM_catalogue

$ chmod +x /full/path/to/AM_catalogue.sh```

3. Change the path until the folder libraries in the first lines of the script

### Lazy readers and express instructions:

To start the system open the bash in the correct folder and insert the command to start the script:

```$ ./AM_catalogue.sh```

Then select the option of your desire.

**A. Searching by Key-words or access:**

A.1. To search in the PFAM database it is allowed to use key-words or PFAM code.

A.2. To search in KEGG, COG and Uniprot database you should use KO, COG and GO numbers, respectivelly.

A.3. To search in the DBCAN database you should use the families names used in the CAZY (e.g. GH9)

A.4. To search in the EGGNOG database it is allowed, as PFAM, search key-words and EGGNOG families.

The option of multiple DBs is used generally to retrieve annotation in several DBs for specific gene/protein or a list of genes/proteins.

**B.Searching abundance profiles:**

You should enter the name of the desired gene or a list of them and the system will retrieve a matrix where each line represent a gene and each column a site. The abundances are given as TPM. For more information about these sites, we recomend to read the original papers:

- *Satinsky BM, et al. 2015. Metagenomic and metatranscriptomic inventories of the lower Amazon River, May 2011. Microbiome 3 (39): 1-8. doi:10.1186/s40168-015-0099-0*

- *Toyama D, Kishi LT, Santos-Júnior CD, Soares-Costa A, et al. 2016. Metagenomics Analysis of Microorganisms in Freshwater Lakes of the Amazon Basin. Genome Announc. 4:e01440-e16. doi:10.1128/genomeA.01440-16.*

- *Santos-Júnior CD, Kishi LT, Toyama D, Soares-Costa A, et al. 2017. Metagenome sequencing of prokaryotic microbiota collected from rivers in the Upper Amazon Basin. Genome Announc. 5: e01450-e16. doi:10.1128/genomeA.01450-16.*

- *Toyama D, Santos-Júnior CD, Kishi LT, Oliveira TCS, Garcia JW, Sarmento H, Miranda FP,  Henrique-Silva F. 2017. A snapshot on prokaryotic diversity of the Solimões River basin (Amazon, Brazil). Genet. Mol. Res. 16 (2): gmr16029567. doi: 10.4238/gmr16029567*

**C. Homology search using query :**

This system still allows the user to search protein or nucleotide sequences against Amazon gene catalogue, through nhmmer or phmmer. The most important here is to know that this procedure takes a long time since the databases accounts alone with almost 4 million sequences and that these systems are heuristic and need to be human reviewed. The time of search will be increased with the size of query file and the computer capacities. After the search, the system parses the final hmmsearch table using an internal shell script. Protein searches are preferred.

### License

    Amazon Gene Catalogue Search System
    Copyright (C) 2017  Santos-Júnior, CD

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.


### Acknowledgements

We acknowledge to CAPES (Coordenadoria de Aperfeiçoamento de Pessoal de Nível Superior), CNPq (Conselho Nacional de Pesquisa e Desenvolvimento) and Petrobrás for project financiation and scolarship concession.

### Citing this system:

**To cite some usage of the searching system**

Santos-Júnior, CD; Henrique-Silva, F; Logares, R. 2017. AGSSY - Amazon Gene Searching System. [Github link](https://github.com/celiosantosjr/AGSSY/). Accessed in: XXX.

Santos-Júnior, CD; Henrique-Silva, F; Logares, R. 2017. Amazon basin gene catalogue: Uncovering the Amazonian biodiversity and biotechnological potential. (Non published yet).
