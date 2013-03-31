import config
import sampleLoader
import featureManager 
trainSampList = sampleLoader.parseFileList(config.unittestTrainSampleList)
for trainSampFilename in trainSampList:
   print("[INFO] Testing training sample: " + trainSampFilename)
   trainSamp = sampleLoader.loadTrainSample(trainSampFilename)

   print("[INFO] Extracting samples")
   trainFeat = featureManager.extractTrainFeat(trainSamp)
   #print(trainFeat)
   print(trainFeat['scoreFeats'])
   for key,feat in trainFeat['scoreFeats'].items():
      print(key)
      assert(len(feat) == 4), 'the number of feature points doesn\'t match the test sample'
   for key, feat in trainFeat['perfFeats'].items():
      print(key)
      assert(len(feat) == 4), 'the number of feature points doesn\'t match the test sample'


print('Tests passed')
