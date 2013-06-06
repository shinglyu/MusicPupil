#!/usr/bin/python

import sys
import argparse 
import subprocess

import sampleLoader
import config 

def main():
   parser = argparse.ArgumentParser()
   parser.add_argument("inputList", #nargs="1" , 
                       help="Testing sample list.",
                       #default=config.defaultGenScore
                      )
   parser.add_argument("modelFilename", #nargs="1" , 
                       help="Model filename",
                       #default=config.defaultModelFilename
                      )
   parser.add_argument("outputDir", nargs="?" , 
                       help="Music output directory",
                       default = config.defaultOutputDir
                      )
   args = parser.parse_args()


   genList= sampleLoader.parseFileList(args.inputList)
   for genFilename in genList:
         cmd = ["./musicPupilGen.py"]
         cmd.append(genFilename)
         cmd.append(args.modelFilename)
         cmd.append(args.outputDir)

         config.printDebug(" ".join(cmd))
         subprocess.call(" ".join(cmd), shell=True)

if __name__ == "__main__":
    main()

