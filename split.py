'''
Created on May 28, 2013

@author: ALEX
'''
import sys
import time

#reads in .report.txt files and splits it according to chr
#output: SAMPLE.chr*.editready.txt, sorted by pos
def split(fname, oname):
    l = []
    for n in xrange(0, 25):
        tmp = []
        l.append(tmp)
    stime = time.time()
    #read in snplist
    with open(fname, 'r') as f1:
        content = f1.readlines()
    f1.close()
    
    #iterate through content and bin into list of lists by chr #
    for i in xrange(len(content)):
        ind = ''
        chr = ''
        tmp=content[i].strip().split("\t")
        record = []
        record.append(int(tmp[2]))
        record.append(tmp[3])
        record.append(tmp[4])
        chr = tmp[1]
        #enumerate X, Y, MT chromosomes
        if chr == "X":
            chr = 23
        if chr == "Y":
            chr = 24
        if chr == "MT":
            chr = 25
        ind = int(chr)
        l[ind-1].append(record)
    print str(time.time()-stime)+" sec"
    
    #write new file for each chr
    for j in xrange(len(l)):
        l[j].sort(key=lambda col: col[0])
        outname = str(oname)+".chr"+str(j+1)+".editready.txt"
        out = open(outname,'w')
        for k in xrange(len(l[j])):
            out.write(str(l[j][k][0])+"\t"+str(l[j][k][1])+"\t"+str(l[j][k][2])+"\n")
        out.close()
    #WHY DOES THIS PRINT SAME RECORDS FOR EACH CHR?        
    
    print str(time.time()-stime)+" sec"
if __name__ == "__main__":
    split(sys.argv[1], sys.argv[2])
