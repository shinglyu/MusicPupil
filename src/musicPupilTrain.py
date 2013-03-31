#!/usr/bin/python

import sys
import argparse 
import sampleLoader
import featureManager 
import config 
import model

def main():
   parser = argparse.ArgumentParser()
   parser.add_argument("inputList", nargs="?" , 
                       help=("Training sample list."),
                       default=config.defaultTrainSampleList
                      )
   parser.add_argument("modelName", nargs="?" , 
                       help="model filename",
                       default=config.defaultModelFilename
                       )
   args = parser.parse_args()


   trainSampList = sampleLoader.parseFileList(args.inputList)
   trainFeatsList = []
   for trainSampFilename in trainSampList:
      trainSamp = sampleLoader.loadTrainSample(trainSampFilename)
      trainFeat = featureManager.extractTrainFeat(trainSamp)
      trainFeatsList.append(trainFeat)
   featureManager.saveJson(trainFeatsList, config.defaultTrainFeatsFilename);
   m = model.getModelObj();
   m.train(config.defaultTrainFeatsFilename, args.modelName);
   #model.saveModel(modelParam, args.modelName)




if __name__ == "__main__":
    main()

#trainSampList = sampleLoader.parseTrainSampleList()
#for trainSamp in trainSampList:

