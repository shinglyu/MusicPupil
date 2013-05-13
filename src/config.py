DEBUG = True
#DEBUG = False 
defaultTrainSampleList= "../training_samples/trainSampleList.txt"
unittestTrainSampleList="../training_samples/trainSampleList.txt"
defaultGenScore=        "../testing_scores/chop_nc_phrase001"

defaultTrainFeatsFilename="../output/trainFeats.json" #may need to prepend file name 
defaultGenFeatFilename="../output/genFeat.json"
defaultModelFilename=  "../output/model.bin"
defaultOutputDir=      "../output/"
scoreFeatsList = [ "PosInPhrasePercent",
                   "PitchMidiNum",
                   "PitchDiffNextMidiNum",
                   "PitchDiffPrevMidiNum",
                   "Beat",
                   "BeatStrength",
                   "DurationQNote",
                   "DurationRatioNextPercent",
                   "DurationRatioPrevPercent", ]

perfFeatsList = [ "OnsetDiffQNote",
                  "DurationPercent",
                  "VelocityMidiScale",
                ]

modelFuncName = [ #"modelMultiLinearRegress",
                  "modelSVMStruct",
                  #"ha",
                ]

quantizerName= [ "quantizerLinear",
                  #"ha",
                ]
musicOutputFormat= [ "Midi",
                        #"ha",
                   ]
def printDebug(string):
   if DEBUG:
      print("[DEBUG]"),
      print(string)
