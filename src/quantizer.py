import simplejson 

import config

def getQuantizerObj(intvFilename):
   if len(config.modelFuncName) != 1:
      raise Exception("[ERROR] You can only select one quantizer in config.py")
   className = globals()[config.quantizerName[0]]
   return className(intvFilename)

class quantizer:
   def quantize(feats):
      # feats structure
      #  {
      #     feat1name: [1,2,3....2 3 4,...3 9 4,...],
      #     feat2name: [1,2,3....2 3 4,...3 9 4,...],
      #  }
      #
      raise NotImplementedError()
   def dequantize(feats):
      raise NotImplementedError()

class quantizerLinear(quantizer):
   numOfIntvs = 1024;
   intvFilename = None;

   def __init__(self, intvFilename):
      self.intvFilename = intvFilename

   def findCode(self, value, intv):
      smallerIntvs = filter(lambda x: x < value, intv)
      code = len(smallerIntvs)+1 #code starts from 1
      return code
   def reconstructValue(self, code, intv):
      if code == 1:
         return intv[0]
      elif code == len(intv):
         return intv[-1]
      else:
         return (intv[code-2] + intv[code-1])/2
   
   def quantize(self, feat):
      import numpy
      m = numpy.mean(feat)
      std = numpy.std(feat)
      intv = numpy.linspace(m-3*std, m+3*std, self.numOfIntvs)

      #code = map(self.findCode, feat)
      code = [self.findCode(x, intv) for x in feat]

      with open(self.intvFilename, 'w') as f:
         simplejson.dump(intv.tolist(), f, indent=3)
      return code
      
   def dequantize(self, code):
      #code elements should be string, read directly from file
      with open(self.intvFilename, 'r') as f:
         intv = simplejson.load(f)

      feat = [self.reconstructValue(int(x), intv) for x in code]
      return feat





