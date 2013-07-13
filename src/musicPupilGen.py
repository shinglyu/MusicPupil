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
   #wrap genFeat by {} because trainFeats is {score1, score2}
   featureManager.saveJson([genFeat], config.getGenInFeatFilename(args))
   #perfFeats = model.genPerfFeats(config.defaultGenFeatFilename, args.modelFilename)
   m = model.getModelObj()
   perfFeats = m.gen(args)
   #wrap perfFeat by {} because trainFeats is {score1, score2}
   featureManager.saveJson([perfFeats], config.getGenOutFeatFilename(args))

   musicGenerator.genMusic(genScore, args)



if __name__ == "__main__":
    main()

#trainSampList = sampleLoader.parseTrainSampleList()
#for trainSamp in trainSampList
