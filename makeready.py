'''
Created on May 4, 2013

@author: ALEX
'''
import sys
import argparse
import collections

#takes in geneparse files and outputs rsID chr pos ref alt
#makes format ready for reference file editing
def makeready(cmd):
    #create dictionary object called cmd to handle arguments
    #list called files holds each specific argument
    #call by using: files['args'][XX]
    files = cmd['cmd']
    records = []
    uniqueperfile = []
    tmp = []
    #iterate through command line argument files
    for i in xrange(len(files)):
        fname = str(files[i]) 
        #for each file
        with open(fname, 'r') as file:
            for line in file:
                current = str(line)
                records.append(current)
                #combine columns of all files into single unique one
                #0=fname;1=chr;2=pos;3=rs;4=ref;5=alt;6=loc(gene);7=impact;
                #8=genename;9-genetype;10=coding?;11=exonID; 12 = genotype
                #r = rsID, chr, pos, ref, alt
                r = current.split("\t")[3]+"\t"+current.split("\t")[1]+"\t"+current.split("\t")[2]+"\t"+current.split("\t")[4]+"\t"+current.split("\t")[5]
                tmp.append(r)
        file.close()
    for j in xrange(len(tmp)):
        print tmp[j]
#get freq for any column; returns a list of tuples 0=colval 1=freq
def getfreq(rlist):
    tmp2=[]
    #create counter object
    count = collections.Counter(rlist)
    #get frequencies for each element
    freq = count.items()
    #sum of all counts
    total = sum(count.values())
    return freq
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Input any number of filenames.')
    parser.add_argument('cmd', nargs='+')
    makeready(vars(parser.parse_args()))
    
    
