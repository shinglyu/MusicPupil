import cPickle
import config 
def cacheByName(function):
   memo = {}
   def wrapper(*args):
      config.printDebug(args)
      argsStr= args[0]['name']
      config.printDebug(argsStr)
      if argsStr in memo:
         config.printDebug("Cache HIT: " + argsStr)
         return memo[argsStr]
      else:
         rv = function(*args)
         memo[argsStr] = rv
         return rv
   return wrapper

@cacheByName
def extractPosInPhrasePercent(sample):
   scoreOffset = [s['offset'] for s in sample['score'].flat.notes.offsetMap]
   phraseLen = sample['score'].flat.duration.quarterLength
   return map(lambda x:x/phraseLen, scoreOffset)

@cacheByName
def extractPitchMidiNum(sample):
   pitches = sample['score'].flat.notes.pitches
   return map (lambda x:x.midi, pitches)

@cacheByName
def extractPitchDiffNextMidiNum(sample):
   pitches = extractPitchMidiNum(sample)
   pitchDiff = [n2 - n1 for n1, n2 in zip(pitches, pitches[1:])]
   pitchDiff.append(0) #last element has no next
   return pitchDiff

@cacheByName
def extractPitchDiffPrevMidiNum(sample):
   pitches = extractPitchMidiNum(sample)
   pitchDiff = [n1 - n2 for n1, n2 in zip(pitches, pitches[1:])]
   pitchDiff.insert(0,0) #first element has no prev 
   return pitchDiff

@cacheByName
def extractBeat(sample):
   print('[WARN] Beat does not consider metadata yet, '
         'you need music21 score with time signature to get accurate result')
   notes = sample['score'].flat.notes
   return map (lambda x:x.beat, notes)

@cacheByName
def extractBeatStrength(sample):
   print('[WARN] BeatStrength does not consider metadata yet, '
         'you need music21 score with time signature to get accurate result')
   notes = sample['score'].flat.notes
   return map (lambda x:x.beatStrength, notes)

@cacheByName
def extractDurationQNote(sample):
   notes = sample['score'].flat.notes
   return map (lambda x:x.duration.quarterLength, notes)

@cacheByName
def extractDurationRatioNextPercent(sample):
   duras= extractDurationQNote(sample)
   duraRatio= [d2 / d1 for d1, d2 in zip(duras, duras[1:])]
   duraRatio.append(0) #last element has no next
   return duraRatio 

@cacheByName
def extractDurationRatioPrevPercent(sample):
   duras= extractDurationQNote(sample)
   duraRatio= [d1 / d2 for d1, d2 in zip(duras, duras[1:])]
   duraRatio.insert(0, 0) #first element has no prev
   return duraRatio 
