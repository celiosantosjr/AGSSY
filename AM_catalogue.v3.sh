#!/bin/bash

##############################################################################################################################################################################
#################### AGSSY #####################################################################################################################
####################      Célio Dias Santos Júnior       #####################################################################################################################
####################     celio.diasjunior@gmail.com      #####################################################################################################################
##############################################################################################################################################################################


#### Stating libraries
######################
protein=/home/celio/Desktop/AM_catalogue-master/libraries/ORFs_renamed.faa
gene=/home/celio/Desktop/AM_catalogue-master/libraries/ORFs_renamed.fna
abundance_profile=/home/celio/Desktop/AM_catalogue-master/libraries/abundance_profile.tsv.gz
ab_header=/home/celio/Desktop/AM_catalogue-master/libraries/ab.header
ext_py=/home/celio/Desktop/AM_catalogue-master/libraries/ext.py
pfam=/home/celio/Desktop/AM_catalogue-master/libraries/pfam_anno.gz
kegg=/home/celio/Desktop/AM_catalogue-master/libraries/kegg_anno.gz
eggnog=/home/celio/Desktop/AM_catalogue-master/libraries/eggnog_anno.gz
cog=/home/celio/Desktop/AM_catalogue-master/libraries/cog_anno.gz
dbcan=/home/celio/Desktop/AM_catalogue-master/libraries/DBCAN_anno.gz
uniprot=/home/celio/Desktop/AM_catalogue-master/libraries/uniprot_anno.gz
phmmer=/usr/bin/phmmer
nhmmer=/usr/bin/nhmmer
parser=/home/celio/Desktop/AM_catalogue-master/libraries/parser.sh
######################

###########################
# DEFINING SET OF FUNCTIONS
###########################

##### Retrieve sequences
#########################
seq_code ()
{
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="AGSSY"
TITLE="Retrieving sequences"
MENU="Choose one of the following options:"
OPTIONS=(1 "by gene code"
	 2 "by protein code"
	 3 "Quit")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
	       $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
clear

case $CHOICE in
	"1")
		printf 'Enter gene access code list [e.g. /path/to/list/gene_access_list.txt] : '
		read -r opt
		if [ ! -f $opt ]
		then
			whiptail --title "AGSSY Information" --msgbox "Your search terms were not found in file $opt." 8 78
		else
			tmp=`date +"%m%d%Y%H%M"`
			sort $opt | uniq > list
			echo "We will make the search using your query, it could take some moments, please wait"
			python2 $ext_py list $gene; mv ext_out gene_search_$tmp.fasta; rm -rf list
			if [ -s gene_search_$tmp.fasta ]
			then
				whiptail --title "AGSSY Information" --msgbox "Your search result was saved as gene_search_$tmp.fasta." 8 78		
			else
				rm -rf gene_search_$tmp.fasta
				whiptail --title "AGSSY Information" --msgbox "Your search returned an empty status." 8 78		
			fi
		fi
		;;
	"2")
		printf 'Enter protein access code list [e.g. /path/to/list/protein_access_list.txt] : '
		read -r opt
		if [ ! -f $opt ]
		then
			whiptail --title "AGSSY Information" --msgbox "Your search terms were not found in file $opt." 8 78
		else
			tmp=`date +"%m%d%Y%H%M"`
			echo "We will make the search using your query, it could take some moments, please wait"
			sort $opt | uniq > list
			python2 $ext_py list $protein; mv ext_out protein_search_$tmp.fasta; rm -rf list
			if [ -s protein_search_$tmp.fasta ]
			then
				whiptail --title "AGSSY Information" --msgbox "Your search result was saved as protein_search_$tmp.fasta." 8 78		
			else
				rm -rf protein_search_$tmp.fasta
				whiptail --title "AGSSY Information" --msgbox "Your search returned an empty status." 8 78		
			fi
		fi
		;;
	"3")
		whiptail --title "AGSSY Information" --msgbox "You selected Quit option. Thank your for use this software." 8 78		
		break
		;;
	*)
		whiptail --title "AGSSY Information" --msgbox "You selected a invalid option, we are quitting!" 8 78		
		break
		;;
esac
}
#########################

##### Search annotation
#########################
key_code ()
{
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="AGSSY"
TITLE="Retrieving annotation by Key_word"
MENU="Choose one of the following options:"

OPTIONS=(1 "Search in a specific database"
	 2 "Search using a key-word list"
	 3 "Quit")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
clear

case $CHOICE in
	"1")
		HEIGHT=15
		WIDTH=40
		CHOICE_HEIGHT=4
		BACKTITLE="AGSSY"
		TITLE="Retrieving sequences by Key_word"
		MENU="Choose one of the following options:"

		OPTIONS=(1 "PFAM numbers or terms"
			 2 "KO numbers"
			 3 "GO numbers"
			 4 "COG numbers"
			 5 "EGGNOG clusters or terms"
			 6 "DBCAN families or terms"
			 7 "Quit")

		CHOICE=$(dialog --clear \
                		--backtitle "$BACKTITLE" \
		                --title "$TITLE" \
		                --menu "$MENU" \
		                $HEIGHT $WIDTH $CHOICE_HEIGHT \
		                "${OPTIONS[@]}" \
		                2>&1 >/dev/tty)
		clear
		
		case $CHOICE in
			"1")
				printf 'Enter your key-word [e.g. acetyl or PF13649.4] : '
				read -r opt
				tmp=`date +"%m%d%Y%H%M"`
				LANG=C zgrep "$opt" $pfam > kw_search_$tmp.txt
				if [ -s kw_search_$tmp.txt ]
				then
					whiptail --title "AGSSY Information" --msgbox "Your search result was saved as kw_search_$tmp.txt." 8 78
				else
					rm -rf kw_search_$tmp.txt
					whiptail --title "AGSSY Information" --msgbox "Your search result was returned as empty status" 8 78
				fi				
				;;
			"2")
				printf 'Enter your key-word [e.g. K08295] : '
				read -r opt
				tmp=`date +"%m%d%Y%H%M"`
				LANG=C zgrep "$opt" $kegg > kw_search_$tmp.txt
				if [ -s kw_search_$tmp.txt ]
				then
					whiptail --title "AGSSY Information" --msgbox "Your search result was saved as kw_search_$tmp.txt." 8 78
				else
					rm -rf kw_search_$tmp.txt
					whiptail --title "AGSSY Information" --msgbox "Your search result was returned as empty status" 8 78
				fi
				;;
			"3")
				printf 'Enter your key-word [e.g. GO:0003677] : '
				read -r opt
				tmp=`date +"%m%d%Y%H%M"`
				LANG=C zgrep "$opt" $uniprot > kw_search_$tmp.txt
				if [ -s kw_search_$tmp.txt ]
				then
					whiptail --title "AGSSY Information" --msgbox "Your search result was saved as kw_search_$tmp.txt." 8 78
				else
					rm -rf kw_search_$tmp.txt
					whiptail --title "AGSSY Information" --msgbox "Your search result was returned as empty status" 8 78
				fi
				;;
			"4")
				printf 'Enter your key-word [e.g. Coenzyme_transport or a COG number, as COG0043] : '
				read -r opt
				tmp=`date +"%m%d%Y%H%M"`
				LANG=C zgrep "$opt" $cog > kw_search_$tmp.txt
				if [ -s kw_search_$tmp.txt ]
				then
					whiptail --title "AGSSY Information" --msgbox "Your search result was saved as kw_search_$tmp.txt." 8 78
				else
					rm -rf kw_search_$tmp.txt
					whiptail --title "AGSSY Information" --msgbox "Your search result was returned as empty status" 8 78
				fi
				;;
			"5")
				printf 'Enter your key-word [e.g. EGGNOG235652 or a function, like, acetyl] : '
				read -r opt
				tmp=`date +"%m%d%Y%H%M"`
				LANG=C zgrep "$opt" $eggnog > kw_search_$tmp.txt
				if [ -s kw_search_$tmp.txt ]
				then
					whiptail --title "AGSSY Information" --msgbox "Your search result was saved as kw_search_$tmp.txt." 8 78
				else
					rm -rf kw_search_$tmp.txt
					whiptail --title "AGSSY Information" --msgbox "Your search result was returned as empty status" 8 78
				fi
				;;
			"6")
				printf 'Enter your key-word [e.g. acetyl or a DBCAN family, like, GH9] : '
				read -r opt
				tmp=`date +"%m%d%Y%H%M"`
				LANG=C zgrep "$opt" $dbcan > kw_search_$tmp.txt
				if [ -s kw_search_$tmp.txt ]
				then
					whiptail --title "AGSSY Information" --msgbox "Your search result was saved as kw_search_$tmp.txt." 8 78
				else
					rm -rf kw_search_$tmp.txt
					whiptail --title "AGSSY Information" --msgbox "Your search result was returned as empty status" 8 78
				fi
				;;
			"7")
				whiptail --title "AGSSY Information" --msgbox "You selected Quit option. Thank your for use this software." 8 78		
				break
				;;
			*)
				whiptail --title "AGSSY Information" --msgbox "You selected a invalid option, we are quitting!" 8 78		
				break
				;;
		esac
		;;
	"2")
		echo "This search will be operated in all available databases, it could take a while."
		printf 'Enter multiple key-words [e.g. /path/to/list/protein_access_list.txt] : '
		read -r opt
		echo "Using the file list $opt"
		echo "######### Performing search, please be patient."
		if [ ! -f $opt ]
		then
			whiptail --title "AGSSY Information" --msgbox "Your search terms were not found in file $opt." 8 78
		else
			sort $opt | uniq > tmp_var
			tmp=`date +"%m%d%Y%H%M"`
			echo "We will make the search using your query, it could take some moments, please wait"
			touch pfam.tmp
			touch kegg.tmp
			touch uniprot.tmp
			touch cog.tmp
			touch eggnog.tmp
			touch dbcan.tmp
			for i in $(cat tmp_var)
			do
				LANG=C zgrep "$i" $pfam > tmp1
				LANG=C zgrep "$i" $kegg > tmp2
				LANG=C zgrep "$i" $uniprot > tmp3
				LANG=C zgrep "$i" $cog > tmp4
				LANG=C zgrep "$i" $eggnog > tmp5
				LANG=C zgrep "$i" $dbcan > tmp6
				cat tmp1 pfam.tmp > tp; rm -rf tmp1 pfam.tmp; mv tp pfam.tmp
				cat tmp2 kegg.tmp > tp; rm -rf tmp2 kegg.tmp; mv tp kegg.tmp
				cat tmp3 uniprot.tmp > tp; rm -rf tmp3 uniprot.tmp; mv tp uniprot.tmp
				cat tmp4 cog.tmp > tp; rm -rf tmp4 cog.tmp; mv tp cog.tmp
				cat tmp5 eggnog.tmp > tp; rm -rf tmp5 eggnog.tmp; mv tp eggnog.tmp
				cat tmp6 dbcan.tmp > tp; rm -rf tmp6 dbcan.tmp; mv tp dbcan.tmp
			done
			rm -rf tmp_var
			if [ -s pfam.tmp ]
			then
				touch pfam.tmp
			else
				rm -rf pfam.tmp
				echo "PFAM returned empty status" > pfam.tmp
			fi
			if [ -s kegg.tmp ]
			then
				touch kegg.tmp
			else
				rm -rf kegg.tmp
				echo "KEGG returned empty status" > kegg.tmp
			fi
			if [ -s uniprot.tmp ]
			then
				touch uniprot.tmp
			else
				rm -rf uniprot.tmp
				echo "Uniprot returned empty status" > uniprot.tmp
			fi
			if [ -s cog.tmp ]
			then 
				touch cog.tmp
			else
				rm -rf cog.tmp
				echo "COG returned empty status" > cog.tmp
			fi
			if [ -s eggnog.tmp ]
			then
				touch eggnog.tmp
			else
				rm -rf eggnog.tmp
				echo "EGGNOG returned empty status" > eggnog.tmp
			fi
			if [ -s dbcan.tmp ]
			then
				touch dbcan.tmp
			else 
				rm -rf dbcan.tmp
				echo "DBCan returned empty status" > dbcan.tmp
			fi
			echo "##################################################################" > sep
			echo "									" > sep2
			echo "PFAM #############################################################" > pfam
			echo "KEGG #############################################################" > kegg
			echo "UNIPROT ##########################################################" > uniprot
			echo "COG ##############################################################" > cog
			echo "EGGNOG ###########################################################" > eggnog
			echo "DBCAN (CAZY) #####################################################" > dbcan
			cat sep pfam pfam.tmp sep2 sep kegg kegg.tmp sep2 sep uniprot uniprot.tmp sep2 sep cog cog.tmp sep2 sep eggnog eggnog.tmp sep2 sep dbcan dbcan.tmp sep2 sep > $tmp.kw.txt
			rm -rf sep pfam pfam.tmp kegg kegg.tmp uniprot uniprot.tmp cog cog.tmp eggnog eggnog.tmp dbcan dbcan.tmp sep2
			if [ -s $tmp.kw.txt ]
			then 
				whiptail --title "AGSSY Information" --msgbox "Your search results were saved in the script folder as $tmp.kw.txt." 8 78
			else
				rm -rf $tmp.kw.txt
				whiptail --title "AGSSY Information" --msgbox "Your search returned a complete empty status." 8 78
			fi
		fi	
		;;
	"3")
		whiptail --title "AGSSY Information" --msgbox "You selected Quit option. Thank your for use this software." 8 78		
		break
		;;
	*)
		whiptail --title "AGSSY Information" --msgbox "You selected a invalid option, we are quitting!" 8 78		
		break
		;;
esac
}
#########################

##### Search an abundance profile
#################################
abund_search ()
{
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="AGSSY"
TITLE="Retrieving abundance profiles"
MENU="Choose one of the following options:"

OPTIONS=(1 "Retrieve one gene abundance profile"
	 2 "Retrieve multiple gene abundance profiles"
	 3 "Quit")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
clear

case $CHOICE in
	"1")
		printf 'Enter gene access code [e.g. all_1] : '
		read -r opt
		tmp=`date +"%m%d%Y%H%M"`
		LANG=C zgrep "$opt	" $abundance_profile > tmp
		cat $ab_header tmp > abund_$tmp.tpm; rm -rf tmp
		if [ -s abund_$tmp.tpm ]
		then
			whiptail --title "AGSSY Information" --msgbox "Your search result was saved as abund_$tmp.tpm." 8 78		
		else
			rm -rf abund_$tmp.tpm tmp tmp2 abund.tmp
			whiptail --title "AGSSY Information" --msgbox "Your search returned empty status." 8 78		
		fi
		;;
	"2")
		printf 'Enter gene access code list [e.g. /path/to/list/gene_access_list.txt] : '
		read -r opt
		if [ ! -f $opt ]
		then
			whiptail --title "AGSSY Information" --msgbox "Your search terms were not found in file $opt." 8 78
		else
			tmp=`date +"%m%d%Y%H%M"`
			echo "We will make the search using your query, it could take some moments, please wait"
			sort -k1,1 $opt | uniq > tmp
			join tmp <(zcat $abundance_profile) | sed 's/ /\t/g' > tmp2
			rm -rf tmp; cat $ab_header tmp2 > abund_$tmp.tpm; rm -rf tmp2
			if [ -s abund_$tmp.tpm ]
			then
				whiptail --title "AGSSY Information" --msgbox "Your search result was saved as abund_$tmp.tpm." 8 78			
			else
				rm -rf abund_$tmp.tpm tmp tmp1 tmp2 tmp3 tmp0
				whiptail --title "AGSSY Information" --msgbox "Your search returned empty status." 8 78		
			fi
		fi		
		;;
	"3")
		whiptail --title "AGSSY Information" --msgbox "You selected Quit option. Thank your for use this software." 8 78		
		break
		;;
	*)
		whiptail --title "AGSSY Information" --msgbox "You selected a invalid option, we are quitting!" 8 78		
		break
		;;
esac
}
#################################

##### Search by homology
#################################
homology ()
{
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="AGSSY"
TITLE="Retrieving abundance profiles"
MENU="Choose one of the following options:"

OPTIONS=(1 "Nucleotide search"
	 2 "Protein Search"
	 3 "Quit")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
clear

case $CHOICE in
	"1")
		printf 'Enter nucleotide sequences query file [e.g. /path/to/list/nt.fna] : '
		read -r opt
		tmp=`date +"%m%d%Y%H%M"`
		if [ -z "$opt" ]
		then
			whiptail --title "AGSSY Information" --msgbox "Your reference file is empty." 8 78		
		else
			if  [ -s $opt ]
			then
				echo "We will make the search using your, it could take some moments, please wait"
				cat $opt | awk '{if (substr($0,1,1)==">"){if (p){print "\n";} print $0} else printf("%s",$0);p++;}END{print "\n"}' > query
				mv $opt $opt.tt
				awk '/^>/ {OUT=substr($0,2) ".fa"}; {print >> OUT; close(OUT)}' query
				ls *.fa > list
				sed -i 's/ .fa//g' list
				for i in $(cat list)
				do
					mv "$i .fa" $i.fa
				done
				rm -rf list; touch tmp_mother
				for i in $(ls *.fa)
				do
					$nhmmer --dfamtblout tmp -E 1e-5 --dna --cpu 6 $i $gene
					grep "#" tmp > header
					cat tmp_mother tmp > tt; rm -rf tmp_mother tmp; mv tt tmp_mother
				done
				sed -i '/#/d' tmp_mother
				cat header tmp_mother > tmp; rm -rf tmp_mother header
				mv tmp homology_search.$tmp.tbl; rm -rf query *.fa; mv $opt.tt $opt
				whiptail --title "AGSSY Information" --msgbox "Your search result was saved as homology_search.$tmp.tbl." 8 78		
			else
				whiptail --title "AGSSY Information" --msgbox "Your reference file is empty." 8 78		
			fi
		fi
		;;
	"2")
		printf 'Enter protein sequences query file [e.g. /path/to/list/ptn.fna] : '
		read -r opt
		tmp=`date +"%m%d%Y%H%M"`
		if [ -z "$opt" ]
		then
			whiptail --title "AGSSY Information" --msgbox "Your reference file is empty." 8 78		
		else
			if  [ -s $opt ]
			then
				echo "We will make the search using your query, it could take some moments, please wait"
				cat $opt | awk '{if (substr($0,1,1)==">"){if (p){print "\n";} print $0} else printf("%s",$0);p++;}END{print "\n"}' > query
				sed -i '/^\s*$/d' query
				sed -i "s/\*//g" query
				mv $opt $opt.tt		
				$phmmer --domtblout tmp -E 1e-5 --cpu 6 query $protein
				sh $parser tmp > homology_search.$tmp.tbl; rm -rf tmp; mv $opt.tt $opt; rm -rf query
				whiptail --title "AGSSY Information" --msgbox "Your search result was saved as homology_search.$tmp.tbl." 8 78		
			else
				whiptail --title "AGSSY Information" --msgbox "Your reference file is empty." 8 78		
			fi
		fi
		;;
	"3")
		whiptail --title "AGSSY Information" --msgbox "You selected Quit option. Thank your for use this software." 8 78		
		break
		;;
	*)
		whiptail --title "AGSSY Information" --msgbox "You selected a invalid option, we are quitting!" 8 78		
		break
		;;
esac
}
#################################


########################################################## MAIN ###########################################################################################################

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="AGSSY"
TITLE="Menu"
MENU="Choose one of the following options:"

OPTIONS=(1 "Retrieve sequences"
	 2 "Search by keyword,PFAM,KO,COG"
 	 3 "Search an abundance profile"
	 4 "Homology search using a query"
	 5 "Quit"
	 6 "INFORMATION")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
clear

case $CHOICE in
	"1")
		seq_code
		;;
	"2")
		key_code
		;;
	"3")
		abund_search
		;;
	"4")
		homology
		;;
	"5")
		whiptail --title "AGSSY Information" --msgbox "You selected Quit option. Thank your for use this software." 8 78		
		break
		;;
	"6")		
		whiptail --title "AGSSY Information" --msgbox "Welcome to Amazon Gene Catalogue, a joint production of UFSCAR, Petrobrás and ICM/CSIC-Spain. This script is a courtesy of Célio Dias Santos-Jr." 8 78

		HEIGHT=15
		WIDTH=40
		CHOICE_HEIGHT=4
		BACKTITLE="AGSSY"
		TITLE="Menu"
		MENU="Choose one of the following options:"
		
		OPTIONS=(1 "Retrieve sequences"
			 2 "Search by keyword,PFAM,KO,COG"
		 	 3 "Search an abundance profile"
			 4 "Homology search using a query"
			 5 "Quit")
		
		CHOICE=$(dialog --clear \
		                --backtitle "$BACKTITLE" \
		                --title "$TITLE" \
		                --menu "$MENU" \
		                $HEIGHT $WIDTH $CHOICE_HEIGHT \
		                "${OPTIONS[@]}" \
		                2>&1 >/dev/tty)
		clear
	
		case $CHOICE in
			"1")
				gene_code	
				;;
			"2")
				key_code
				;;
			"4")
				abund_search
				;;
			"5")
				homology
				;;
			"6")
				whiptail --title "AGSSY Information" --msgbox "You selected Quit option. Thank your for use this software." 8 78		
				break
				;;
			*)
				whiptail --title "AGSSY Information" --msgbox "You selected a invalid option, we are quitting!" 8 	78		
				break
				;;
		esac
		;;
	*)
		whiptail --title "AGSSY Information" --msgbox "You selected a invalid option, we are quitting!" 8 78		
		break
		;;
esac
