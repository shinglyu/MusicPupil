import featureManager
import config
import music21



def getMusicOutputFunc():
   try:
      if len(config.musicOutputFormat) != 1:
         raise Exception()
      func = globals()['output' + config.musicOutputFormat[0]]
      return func 
   except Exception:
      print("[ERROR] You can only select one music output format function in config.py")
      raise 

def genMusic(genScore, perfFeats, args):
   outScore = featureManager.applyFeats(genScore, perfFeats)
   musicOutputFunc = getMusicOutputFunc()
   musicOutputFunc(outScore, args)

def outputMidi(outSamp, args):
   outputFilename = config.sanitizeDirPath(args.outputDir) 
   outputFilename += config.getGenSampleName(args.input) + '.expr.mid'
   config.printDebug(outputFilename)
   outScore = outSamp['score']
   outScore.write('midi', outputFilename)
   #midifile = music21.midi.translate.streamToMidiFile(outScore)
   #midifile.open(outputFilename, 'wb')
   #midifile.write()
   #midifile.close()
   
