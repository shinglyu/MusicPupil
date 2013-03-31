from music21 import *
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
def extractOnsetDiffQNote(sample):
   scoreOffset = [s['offset'] for s in sample['score'].flat.notes.offsetMap]
   perfOffset = [p['offset'] for p in sample['perf'].flat.notes.offsetMap]
   offsetDiff = [ s - p for s, p in zip(scoreOffset, perfOffset)]
   return offsetDiff

def applyOnsetDiffQNote(inSample, perfFeats):
   offsetDiffs = perfFeats['OnsetDiffQNote']
   notes = inSample['score'].flat.notes
   outScore= stream.Stream()
   for offsetDiff, note in zip(offsetDiffs, notes):
      outOffset = max(0, note.offset + offsetDiff)
      outScore.insert(outOffset, note)
   outSample = { 'name': inSample['name'], 'meta':inSample['meta'],
                 'score': outScore
               }
   return outSample

   
@cacheByName
def extractDurationPercent(sample):
   scoreNotes = sample['score'].flat.notes
   perfNotes = sample['perf'].flat.notes
   if config.DEBUG:
      for s, p in zip(scoreNotes, perfNotes):
         config.printDebug('s duration: '+ str(s.duration.quarterLength))
         config.printDebug('p duration: '+ str(p.duration.quarterLength))
   durationPercents = [p.duration.quarterLength / s.duration.quarterLength 
                       for s, p in zip(scoreNotes, perfNotes)]
   return durationPercents

def applyDurationPercent(inSample, perfFeats):
   outScore = inSample['score']
   notes = outScore.flat.notes
   durationPercents = perfFeats['DurationPercent']
   for durationPercent, note in zip(durationPercents, notes):
      outDuration = note.duration.quarterLength * durationPercent
      config.printDebug(outDuration)
      note.duration =  duration.Duration(outDuration)
   outSample = { 'name': inSample['name'], 
                 'meta':inSample['meta'],
                 'score': outScore
               }
   return outSample

@cacheByName
def extractVelocityMidiScale(sample):
   perfNotes = sample['perf'].flat.notes
   return map(lambda n:n.volume.velocity, perfNotes)

def applyVelocityMidiScale(inSample, perfFeats):
   outScore = inSample['score']
   notes = outScore.flat.notes
   vels= perfFeats['VelocityMidiScale']
   for vel, note in zip(vels, notes):
      note.volume.velocity = vel
   outSample = { 'name': inSample['name'], 
                 'meta':inSample['meta'],
                 'score': outScore
               }
   return outSample
