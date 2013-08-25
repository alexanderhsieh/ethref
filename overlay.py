'''
Created on May 28, 2013

@author: ALEX

This script customizes hg19.fasta reference genome using variant information taken as consensus of ethnic individuals 
Outputs an ethnicity specific reference genome file
'''
import sys
import time
#overlay split chr snp profile text file onto split chr reference fasta file
def overlay(snpsname, refname):
    stime = time.time()
    s = ''
    snplist = []
    #read in ref sequence
    with open(refname,'r') as ref:
        for line in ref:
            if not line.startswith(">"):
                s += str(line.strip())
            else:
                head = line
    ref.close()
    seq = list(s)
    #print "length of ref: "+str(len(s))
    #print str(time.time()-stime)+" sec"
    stime2 = time.time()
    #read snps into memory
    with open(snpsname,'r') as snps:
        for line in snps:
            tmp = line.split()
            index = int(tmp[0])
            ref = str(tmp[1])
            alt = str(tmp[2])
            if seq[index] == ref:
                seq[index] = alt
            else:
                continue
    print head
    print ''.join(seq)
    #print str(time.time()-stime2)+" sec"
    #print "\n"
    #print "total: "+str(time.time()-stime2)+" sec"
if __name__ == "__main__":
    overlay(sys.argv[1], sys.argv[2])
