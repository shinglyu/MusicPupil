#!/usr/bin/python

import sys
import argparse 
import sampleLoader
import featureManager 
import model 
import config 
import musicGenerator

def main():
   parser = argparse.ArgumentParser()
   parser.add_argument("input", #nargs="1" , 
                       help="Score to be played, without extension.",
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


   genScore = sampleLoader.loadGenScore(args.input)
   genFeat = featureManager.extractGenFeat(genScore)
   featureManager.saveJson(genFeat, config.getGenFeatFilename(args))
   #perfFeats = model.genPerfFeats(config.defaultGenFeatFilename, args.modelFilename)
   m = model.getModelObj()
   perfFeats = m.gen(args)
   musicGenerator.genMusic(genScore, perfFeats, args)



if __name__ == "__main__":
    main()

#trainSampList = sampleLoader.parseTrainSampleList()
#for trainSamp in trainSampList
