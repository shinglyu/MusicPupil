#!/usr/bin/python

import sys
import argparse 
import sampleLoader
import featureManager 
import config 
import model
import os.path 

def main():
   parser = argparse.ArgumentParser()
   parser.add_argument("inputList", #nargs="?" , 
                       help=("Training sample list."),
                       #default=config.defaultTrainSampleList
                      )
   parser.add_argument("outputDir", nargs="?" , 
                       help="Music output directory",
                       default = config.defaultOutputDir
                      )
   #parser.add_argument("modelName", nargs="?" , 
   #                    help="model filename",
   #                    default=config.defaultModelFilename
   #                    )
   args = parser.parse_args()


   trainSampList = sampleLoader.parseFileList(args.inputList)

   trainFeatsList = []
   for trainSampFilename in trainSampList:
      trainSamp = sampleLoader.loadTrainSample(trainSampFilename)
      trainFeat = featureManager.extractTrainFeat(trainSamp)
      trainFeatsList.append(trainFeat)

   trainFeatFilename = config.getTrainInFeatFilename(args)
   featureManager.saveJson(trainFeatsList, trainFeatFilename);

   m = model.getModelObj();
   #modelName = config.getModelFilename(args)
   m.train(args); #load features from config.getTrainInFeatFilename(args)
   #model.saveModel(modelParam, args.modelName)




if __name__ == "__main__":
    main()

#trainSampList = sampleLoader.parseTrainSampleList()
#for trainSamp in trainSampList:

