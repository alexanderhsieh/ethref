ethref
======

A tool to identify ethnicity given a vcf file and to generate ethnic population-specific reference genomes

#-------------------------------------------------------#
 EthRef: Variant annotation and Genome Customization Kit
#-------------------------------------------------------#

Author
------
Alexander Hsieh
BIMM185 Spring 2013
University of California, San Diego
06/13/2013


What is it?
-----------

EthRef is a set of tools that allows researchers to easily call, annotate, and analyze variants.  Given the variant profile of an sample, EthRef then determines, using haplotype data supplied by 1000 Genomes Project, the most similar ethnic group (among African, East Asian, and European).  As a final step, EthRef generates a synthetic reference genome, customizing hg19 with the ethnic group assigned to the given sample.

Files Included
--------------

ethref.bam.sh
ethref.fastq.sh
ethref.vcf.sh
setupfiles.sh

samtools-0.1.19.tar.bz2
snpEff_latest_core.zip

test.ASW.vcf.gz
test.CHD.vcf.gz
test.TSI.vcf.gz

under /python
	APchoice.py
	happarse.py
	makeready.py
	makereport.py
	mapper.py
	overlay.py
	split.py

under /ref
	customize.sh
	gethapparse.sh
	split.sh
	african.editready.txt.gz
	eastasian.editready.txt.gz
	european.editready.txt.gz

Example Usage
-------------

1) "I have test.ASW.vcf and I want to determine its ethnicity, generate a easy-to-read report, and build a customized reference genome"

	sh ethref.vcf.sh test.ASW.vcf hg19 /home/alhsieh/snpEff/ testASW

-Output: testASW.snpEff.vcf, testASW.report.txt, testASW.pop.txt, african.chr*.fasta

2) "I have test.CEU.bam and I want to determine its ethnicity, generate a easy-to-read report, and build a customized reference genome"

	sh ethref.bam.sh test.CEU.bam ref/hg19.fasta hg19 samtools-0.1.19/ /home/alhsieh/snpEff testCEU

-Output: testCEU.vcf, testCEU.rsmapped.vcf, testCEU.snpeff.vcf, testCEU.report.txt, testCEU.pop.txt, european.chr*.fasta

3) "I have test.CHB.fastq and I want to determine its ethnicity, generate a easy-to-read report, and build a customized reference genome"

	sh ethref.fastq.sh test.CHB.fastq ref/hg19.fasta hg19 samtools-0.1.19/ /home/alhsieh/snpEff/ testCHB

-Output: testCHB.sam, testCHB.bam, testCHB.vcf, testCHB.rsmapped.vcf, testCHB.snpeff.vcf, testCHB.report.txt, testCHB.pop.txt, eastasian.chr*.fasta

4) "I have test.ASW.vcf and only want to know ethnicity (I don't care about custom reference)"
	
	python python/APchoice.py test.ASW.vcf ref/hapdata.popstats.txt

5) "I just want an custom genome for [population]"
*note: must run from ethref home directory

	sh customize.sh [population]

-Output: [population].chr*.fasta
-note: currently, [population] is limited to {african, eastasian, european}




Installing Dependencies
-----------------------

BEFORE INSTALLING ANYTHING ELSE:
1) Unpack and Install Samtools (.bz2 included)
	
	tar -xjvf samtools-0.1.19.tar.bz2
	cd samtools-0.1.19
	make
	
	-if make command fails (compilation exits with ncurses error), open Make file in editor:
		-change the line "-D_CURSES_LIB=1" to "-D_CURSES_LIB=0"
		-comment out the line "LIBCURSES=     -lcurses # -lXCurses"
		-this should allow samtools to finish compiling
	-configuring the path is recommended but not required (scripts work out of local directory)

2) Move snpEff to home directory, Unpack and Install.  Setup database files.
	
	wget http://downloads.sourceforge.net/project/snpeff/snpEff_latest_core.zip?r=http%3A%2F%2Fsnpeff.sourceforge.net%2F&ts=1371162528&use_mirror=superb-dca3
	mv snpEff_latest_core.zip?r=http%3A%2F%2Fsnpeff.sourceforge.net%2F&ts=1371162528&use_mirror=superb-dca3 snpEff_latest_core.zip
	unzip snpEff_latest_core.zip
	cd snpEff
	java -jar snpEff.jar download -v hg19
	
	-if downloading snpEff database version of hg19 fails, can manually add the database
		cd snpEff/data
		mkdir hg19
		cd hg19
		wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/human_g1k_v37.fasta.gz
		mv human_g1k_v37.fasta.gz sequences.fa
		wget ftp://ftp.ensembl.org/pub/release-71/gtf/homo_sapiens/Homo_sapiens.GRCh37.71.gtf.gz
		mv Homo_sapiens.GRCh37.71.gtf.gz genes.gtf.gz
	-once added, cd to snpEff home directory, run
		java -jar snpeff.jar build -gtf22 -v hg19


Installation/Configuration
--------------------------

Automatic:
----------

	sh setupfiles.sh

	-Downloads and Parses haplotype data files; Deletes files post-processing (since some files are several Gb!)
	-Downloads, Renames, and Splits human reference genome files used in 1000 Genomes Project (genome customization is by chromosome)
	-Prepares ethnicity-specific files by splitting editready.txt files by chr, for customization purposes

Manual:
-------

1) Download and Parse haplotype data files:

	sh gethapparse.sh
	cat *.popstats.txt > hapdata.popstats.txt
	
	-gethapparse.sh downloads haplotype data for each chromosome, unzips the file, runs happarse.py to generate .popstats.txt files
	-cat merges the .popstats.txt files into a single file to be read by APchoice.py, for ethnicity selection

2) Download and Process Human Reference Genome (hg19):

	wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/human_g1k_v37.fasta.gz
	gunzip human_g1k_v37.fasta.gz
	mv human_g1k_v37.fasta > hg19.fasta
	awk '/^>/{f="hg19."++d".fasta"} {print > f}' hg19.fasta

	-wget to fetch the file from 1000 Genomes FTP server
	-gunzip to extract
	-mv to rename human_g1k_v37.fasta to hg19.fasta (for readability/convenience)
	-awk to split hg19.fasta by chromosome (1-25 are the relevant fasta files, rest are contigs that do not factor into analysis)

3) Download dbSNP release 137
	
	wget http://hgdownload.cse.ucsc.edu/goldenPath/hg19/database/snp137.txt.gz
	gunzip snp137.txt.gz

	-wget to fetch file from UCSC database

4) Prepare ethnicity-specific .editready.txt files for customiziation
	
	sh ref/split.sh

	-splits each [population].editready.txt file by chromosome


Required Files Checklist (Post-Installation)
--------------------------------------------

In /ref
Required for genome customization:
	african.chr*.editready.txt
	eastasian.chr*.editready.txt
	european.chr*.editready.txt

Required for variant calling, annotation, and analysis.  Also genome customization.
	hg19.fasta
	hg19.1.fasta, … , hg19.84.fasta

Required for assigning sample snps to rsIDs.  Also ethnicity selection.	
	snp137.txt
	hapdata.popstats.txt


Shell Scripts Explained
-----------------------

	1) customize.sh:
		
		-Runs overlay.py on each reference file, for a given population
		-USAGE: sh customize.sh [population]
		-ex: sh customize.sh african
		-customizes hg19.fasta files with [population].editready.txt files
		-output: [population].chr*.fasta
		-currently, [population] limited to {african, eastasian, european}
		-note: as it is part of a pipe, should be run from EthRef home directory

	2) ethref.bam.sh:

		-Supplementary EthRef service, handles bam -> vcf
		-USAGE: sh ethref.bam.sh [input_bam] [ref_fasta] [genome_ver (hg19)] [samtools_loc][snpeff_loc] [out_name]
		-ex: sh ethref.bam.sh ceu.bam ref/hg19.fasta hg19 samtools-0.1.19/ /home/alhsieh/snpEff/ ceu_hg19
		-takes bam file, calls and annotates variants, chooses ethnicity, customizes hg19
		-output:[out_name].vcf (variants file)
			[out_name].snpeff.vcf (snpEff annotated variants)
			[out_name].report.txt (excel-ready tab-delimited report)
			[out_name].pop.txt (winning population group, stats for subgroups)
			[eth_choice].chr*.fasta (customized reference genome, based on eth_choice)

	3) ethref.fastq.sh:

		-Supplementary EthRef service, handles fastq -> vcf
		-Usage: sh ethref.bam.sh [input_fastq] [ref_fasta] [genome_ver (hg19)] [samtools_loc] [snpeff_loc] [out_name]
		-ex: sh ethref.fastq.sh SRR013301.fastq ref/hg19.fasta hg19 samtools-0.1.19/ /home/alhsieh/snpEff/ SRR013301_hg19
		-takes fastq file, generates alignment against hg19, calls and annotates variants, chooses ethnicity, customizes hg19
		-output:[out_name].sam (sequence alignment mapping)
			[out_name].bam (binary SAM)
			[out_name].vcf (variants file)
			[out_name].snpeff.vcf (snpEff annotated variants)
			[out_name].report.txt (excel-ready tab-delimited report)
			[out_name].pop.txt (winning population group, stats for subgroups)
			[eth_choice].chr*.fasta (customized reference genome, based on eth_choice)

	4) ethref.vcf.sh:
		
		-The main ethref service
		-Usage: sh ethref.vcf.sh [input_vcf] [genome_ver (hg19)] [snpeff_loc] [out_name]
		-ex: sh ethref.vcf.sh chb.rsmapped.vcf hg19 /home/alhsieh/snpEff chb_hg19
		-takes vcf file, annotates variants, chooses ethnicity, customizes hg19 
		-output:[out_name].vcf (variants file)
			[out_name].snpeff.vcf (snpEff annotated variants)
			[out_name].report.txt (excel-ready tab-delimited report)
			[out_name].pop.txt (winning population group, stats for subgroups)
			[eth_choice].chr*.fasta (customized reference genome, based on eth_choice)

	5) gethapparse.sh:
		
		-setup script, fetches required haplotype data files for analysis
		-downloads haplotype data for each chromosome, from 1000 Genomes FTP server
		-runs happarse.py on each chromosome to generate .popstats.txt files
		-chr1-22,X; all files are concatenated to make hapdata.popstats.txt
		

	6) [population]vcf.sh:
		
		-setup script, fetches required vcf files for analysis
		-downloads and unpacks vcf data for [population], by chromosome

	7) [population].snpeff.sh:
		
		-setup script, annotates each chromosomal vcf files with snpEff

	8) setupfiles.sh
		
		-installation script, basically creates the entire environment in one go
		-Downloads and Parses haplotype data files; Deletes files post-processing (since some files are several Gb!)
		-Downloads, Renames, and Splits human reference genome files used in 1000 Genomes Project (genome customization is by chromosome)
		-Prepares ethnicity-specific files by downloading vcf files for each chromosome, creating snpeff.vcf files, .report.txt files, and finally .editready.txt files
	
	9) split.sh

		-setup script, splits [population].editready.txt by chromosome, for editing
	

Python Scripts Explained
------------------------
	under /python

	1) APchoice.py:
		
		-INPUT: [sample].vcf, hapdata.popstats.txt, [out_name]
		-Reads each SNP from [sample].vcf, compares to hapdata.popstats.txt, picks winner
		-based on prob1 scores = #Alternate Alleles / #Individuals * 2 alleles per person
		-Gives value for prevalence of variant in population groups
		-OUTPUT: [sample].pop.txt (has winning population selection, and subgroup stats)
		-output is piped to customize.sh in the full pipeline

	2) happarse.py:
		
		-INPUT: [haplotype file].chr*.vcf
		-Separates data columns by population to pull genotypes
		-Calculates prob1 scores for each of 7 populations in [haplotype file].chr*.vcf
		-OUTPUT: chr*.popstats.txt (has probe scores for each pop, for each SNP)
		-.popstats.txt files are concatenated to make hapdata.popstats.txt

	3) makeready.py
		
		-INPUT: any number of [sample].report.txt files
		-Pulls rsID, chr, pos, ref allele, alt allele from report file
		-OUTPUT: [sample].editready.txt (format for customizing reference file)

	4) makereport.py
		
		-INPUT: any number of [sample].snpeff.vcf files
		-Makes excel import-ready tab-delimited report containing (sample name, chr, pos, rsID, ref allele, alt allele, functional class, impact level, gene name, gene type, non/coding, exon ID)
		-OUTPUT: [sample].report.txt (containing information described above)
		
	5) mapper.py
		
		-INPUT: snp137.txt, [sample].vcf(missing rsIDs), [outname]
		-For each SNP in [sample].vcf, assign corresponding rsID
		-Rewrites entire vcf (with rsIDs added) to [outname].rsmapped.vcf
		-OUTPUT: [outname].rsmapped.vcf (same vcf format, but with rsIDs)

	6) overlay.py
	
		-INPUT: [population].chr*.editready.txt, hg19.*.fasta
		-Uses .editready.txt as guide for navigating and editing hg19.*.fasta
		-OUTPUT: [population].chr*.fasta (human reference genome, specific to [population])

	7) split.py

		-INPUT: [sample].report.txt, [outname]
		-Parses .report.txt for information relevant to genome editing
		-OUTPUT:[outname].editready.txt



