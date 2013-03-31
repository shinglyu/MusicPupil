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
   parser.add_argument("input", nargs="?" , 
                       help="Score to be played",
                       default=config.defaultGenScore
                      )
   parser.add_argument("modelFilename", nargs="?" , 
                       help="Model filename",
                       default=config.defaultModelFilename
                      )
   parser.add_argument("outputDir", nargs="?" , 
                       help="Music output directory",
                       default = config.defaultOutputDir
                      )
   args = parser.parse_args()


   genScore = sampleLoader.loadGenScore(args.input)
   genFeat = featureManager.extractGenFeat(genScore)
   featureManager.saveJson(genFeat, config.defaultGenFeatFilename)
   #perfFeats = model.genPerfFeats(config.defaultGenFeatFilename, args.modelFilename)
   m = model.getModelObj()
   perfFeats = m.gen(config.defaultGenFeatFilename, args.modelFilename)

   musicGenerator.genMusic(genScore, perfFeats, args.outputDir)



if __name__ == "__main__":
    main()

#trainSampList = sampleLoader.parseTrainSampleList()
#for trainSamp in trainSampList
