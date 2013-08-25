'''
Created on Apr 29, 2013

@author: ALEX

This takes a vcf as input and generates a tab-delimited excel-importable text file
Contains (sample name, chr, pos, rsID, ref allele, alt allele, functional class, impact level, gene name, gene type, non/coding, exon ID)
'''
import sys
import argparse

#input: .snpeff.vcf files
#makes report containing samplename, chr#, pos, snp rs id, ref all, alt all, funct class, impact level, gene name, gene type, non/coding, exon name)
def main(cmd):
    #create dictionary object called cmd to handle arguments
    #list called files holds each specific argument
    #call by using: files['args'][XX]
    files = cmd['cmd']
    #print "taking "+str(len(files))+" files as input"
    for i in xrange(len(files)):
        fname = str(files[i])
        #geneparse each file read in
        records = parse(fname)   
#function to parse samplename, chr#, pos, snp rs id, ref all, alt all, funct class, impact level, gene name, gene type, non/coding, exon name)
def parse(fname):
    records = []
    with open(fname, "r") as file:
        for line in file:
            current = line
            if not current.startswith('#'):
                arr = line.split("\t")
                eff = arr[7].split("EFF=")[1].split(",")
                for e in eff:
                    imp = e.split("|")
                    effImpact = imp[0].split("(")
                    #if (effImpact[1] == "HIGH") | (effImpact[1] == "MODERATE"):
                    record = str(fname+"\t"+arr[0]+"\t"+ arr[1]+"\t"+arr[2]+"\t"+arr[3]+"\t"+arr[4]+"\t"+effImpact[0]+"\t"+effImpact[1]+"\t"+imp[5]+"\t"+imp[6]+"\t"+imp[7]+"\t"+imp[8]+"\t"+imp[9].rstrip(")")+"\t"+arr[9].split(":")[0])
                    records.append(record)
                    print record
    file.close()
    return records
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Input any number of filenames.')
    parser.add_argument('cmd', nargs='+')
    main(vars(parser.parse_args()))
