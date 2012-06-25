#!/bin/python
import sys
import re

scoreNamePattern = re.compile(r"(Perform Score:)([a-zA-Z0-9\._]*)(=*)")
staticsPattern= re.compile(r"([a-zA-Z0-9- ]*): ([0-9]+.[0-9]+|-Inf)")
for arg in sys.argv:
#logPath = "../../out/"
   inFname = arg 
   print(inFname)
   inFile = open(inFname)
   #for line in inFile:
         #match = staticsPattern.search(line)
         #if match != None:
            #sys.stdout.write(match.group(1))
            #sys.stdout.write("\t")
            #break

   sys.stdout.write("\t\t\t\tR2\tF\tp\terror\n")
   counter = 0;
   for line in inFile:
      match = scoreNamePattern.search(line)
      if match != None:
         sys.stdout.write("\n")
         sys.stdout.write(match.group(2))
         sys.stdout.write("\t")
         #print(match.group(2))
      match = staticsPattern.search(line)
      if match != None:
         #print(match.group())
         sys.stdout.write(match.group(2))
         sys.stdout.write("\t")
         counter+=1
         if counter == 4:
            sys.stdout.write("\n")
            sys.stdout.write("\t\t\t\t")
            counter = 0;


      #scoreNamePos = line.find('Perform Score:')
      #if scoreNamePos > 0:
      #   print(scoreNamePos)

