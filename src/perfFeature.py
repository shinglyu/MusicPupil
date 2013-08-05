from music21 import *

import config
import logging

def cacheByName(function):
   memo = {}
   def wrapper(*args):
      #logging.printDebug(args)
      argsStr= args[0]['name']
      #logging.printDebug(argsStr)
      if argsStr in memo:
         #logging.printDebug("Cache HIT: " + argsStr)
         return memo[argsStr]
      else:
         rv = function(*args)
         memo[argsStr] = rv
         return rv
   return wrapper

@cacheByName
def getWeakStartOffset(sample):
   #internal use, not for modeling
   return sample['score'].flat.notes.offsetMap[0]['offset'] #Align the last note onset

# Not used now, try extractTempoRatio1~4
@cacheByName
def extractTempoRatio(sample):
   #align first and last note onsets
   scoreLength = sample['score'].flat.notes.offsetMap[-1]['offset'] #Align the last note onset
   weakStartOffset = getWeakStartOffset(sample)
   perfLength = sample['perf'].flat.notes.offsetMap[-1]['offset'] 
   perfStartOffset = sample['perf'].flat.notes.offsetMap[0]['offset'] 
   return (perfLength - perfStartOffset) / (scoreLength - weakStartOffset)

# TempoRatio is not used for as internal feature only
#def applyTempoRatio(inSample, perfFeats):
#   ratio = perfFeats['TempoRatio']
#
#   notes = inSample['score'].flat.notes
#   offsets = inSample['score'].flat.notes.offsetMap
#   weakStartOffset = getWeakStartOffset(sample)
##bug here, check formula
#   #shiftedOffsets = map(lambda x: x - weakStartOffset, offsets) 
#   #appliedOffsets = shiftedOffsets* ratio
#
#   outScore= stream.Stream()
#   for offset, note in zip(offsets, notes):
#      outScore.insert(offset, note)
#   outSample = { 'name': inSample['name'], 'meta':inSample['meta'],
#                 'score': outScore
#               }
#   return outSample
#

@cacheByName
def extractOnsetDiffQNote(sample):
   scoreOffsets = [s['offset'] for s in sample['score'].flat.notes.offsetMap]
   perfOffsets = [p['offset'] for p in sample['perf'].flat.notes.offsetMap]
   perfStartOffset = perfOffsets[0]

   ratio = extractTempoRatio(sample)
   normalizedPerfOffsets= [(p - perfStartOffset) / ratio for p in perfOffsets]

   weakStartOffset = getWeakStartOffset(sample)
   shiftedPerfOffsets = map(lambda x: x + weakStartOffset, normalizedPerfOffsets) 

   logging.printDebug("scoreOffsets:")
   logging.printDebug(scoreOffsets)
   logging.printDebug("perfOffsets:")
   logging.printDebug(perfOffsets)
   logging.printDebug("shiftedPerfOffsets:")
   logging.printDebug(shiftedPerfOffsets)
   logging.printDebug("normalizedPerfOffsets:")
   logging.printDebug(normalizedPerfOffsets)
   
   offsetDiff = [ s - p for s, p in zip(scoreOffsets, shiftedPerfOffsets)]
   return offsetDiff

@cacheByName
def extractTempoRatio1(sample):
   #align first and last note onsets
   scoreLength = sample['score'].flat.notes.offsetMap[-1]['offset'] #Align the last note onset
   weakStartOffset = getWeakStartOffset(sample)
   perfLength = sample['perf'].flat.notes.offsetMap[-1]['offset'] 
   perfStartOffset = sample['perf'].flat.notes.offsetMap[0]['offset'] 
   return (perfLength - perfStartOffset) / (scoreLength - weakStartOffset)

@cacheByName
def extractOnsetDiffQNote1(sample):
   scoreOffsets = [s['offset'] for s in sample['score'].flat.notes.offsetMap]
   perfOffsets = [p['offset'] for p in sample['perf'].flat.notes.offsetMap]
   perfStartOffset = perfOffsets[0]

   ratio = extractTempoRatio1(sample)
   normalizedPerfOffsets= [(p - perfStartOffset) / ratio for p in perfOffsets]

   weakStartOffset = getWeakStartOffset(sample)
   shiftedPerfOffsets = map(lambda x: x + weakStartOffset, normalizedPerfOffsets) 

   logging.printDebug("scoreOffsets:")
   logging.printDebug(scoreOffsets)
   logging.printDebug("perfOffsets:")
   logging.printDebug(perfOffsets)
   logging.printDebug("shiftedPerfOffsets:")
   logging.printDebug(shiftedPerfOffsets)
   logging.printDebug("normalizedPerfOffsets:")
   logging.printDebug(normalizedPerfOffsets)
   
   offsetDiff = [ s - p for s, p in zip(scoreOffsets, shiftedPerfOffsets)]
   return offsetDiff

@cacheByName
def applyOnsetDiffQNote1(inSample, perfFeats):
   return (applyOnsetDiffQNote)

@cacheByName
def extractTempoRatio2(sample):
   #align last note onsets and assume first notes are beat 1
   #possible solution:
   #   - Align last note onset
   #   - Align last note off
   #   - Best align score and perf, minimize onset diff
   scoreLength = sample['score'].flat.notes.offsetMap[-1]['offset'] #Align the last note onset
   weakStartOffset = getWeakStartOffset(sample) + 1 #first note is beat 1 
   perfLength = sample['perf'].flat.notes.offsetMap[-1]['offset'] 
   #perfStartOffset = sample['perf'].flat.notes.offsetMap[0]['offset'] 
   perfStartOffset = 0;
   return (perfLength - perfStartOffset) / (scoreLength - weakStartOffset)

@cacheByName
def extractOnsetDiffQNote2(sample):
   scoreOffsets = [s['offset'] for s in sample['score'].flat.notes.offsetMap]
   perfOffsets = [p['offset'] for p in sample['perf'].flat.notes.offsetMap]
   perfStartOffset = 0;

   ratio = extractTempoRatio2(sample)
   normalizedPerfOffsets= [(p - perfStartOffset) / ratio for p in perfOffsets]

   weakStartOffset = getWeakStartOffset(sample)
   shiftedPerfOffsets = map(lambda x: x + weakStartOffset, normalizedPerfOffsets) 

   logging.printDebug("scoreOffsets:")
   logging.printDebug(scoreOffsets)
   logging.printDebug("perfOffsets:")
   logging.printDebug(perfOffsets)
   logging.printDebug("shiftedPerfOffsets:")
   logging.printDebug(shiftedPerfOffsets)
   logging.printDebug("normalizedPerfOffsets:")
   logging.printDebug(normalizedPerfOffsets)
   
   offsetDiff = [ s - p for s, p in zip(scoreOffsets, shiftedPerfOffsets)]
   return offsetDiff

@cacheByName
def applyOnsetDiffQNote2(inSample, perfFeats):
   return (applyOnsetDiffQNote)

@cacheByName
def extractTempoRatio3(sample):
   #align first note onset and last note off
   #possible solution:
   #   - Align last note onset
   #   - Align last note off
   #   - Best align score and perf, minimize onset diff
   scoreLength = sample['score'].flat.notes.offsetMap[-1]['offset'] #Align the last note onset
   scoreLength += sample['score'].flat.notes[-1].duration.quarterLength
   weakStartOffset = getWeakStartOffset(sample) 
   perfLength = sample['perf'].flat.notes.offsetMap[-1]['offset'] 
   perfLength += sample['score'].flat.notes[-1].duration.quarterLength
   perfStartOffset = sample['perf'].flat.notes.offsetMap[0]['offset'] 
   return (perfLength - perfStartOffset) / (scoreLength - weakStartOffset)

@cacheByName
def extractOnsetDiffQNote3(sample):
   scoreOffsets = [s['offset'] for s in sample['score'].flat.notes.offsetMap]
   perfOffsets = [p['offset'] for p in sample['perf'].flat.notes.offsetMap]
   perfStartOffset = perfOffsets[0];

   ratio = extractTempoRatio3(sample)
   normalizedPerfOffsets= [(p - perfStartOffset) / ratio for p in perfOffsets]

   weakStartOffset = getWeakStartOffset(sample)
   shiftedPerfOffsets = map(lambda x: x + weakStartOffset, normalizedPerfOffsets) 

   logging.printDebug("scoreOffsets:")
   logging.printDebug(scoreOffsets)
   logging.printDebug("perfOffsets:")
   logging.printDebug(perfOffsets)
   logging.printDebug("shiftedPerfOffsets:")
   logging.printDebug(shiftedPerfOffsets)
   logging.printDebug("normalizedPerfOffsets:")
   logging.printDebug(normalizedPerfOffsets)
   
   offsetDiff = [ s - p for s, p in zip(scoreOffsets, shiftedPerfOffsets)]
   return offsetDiff

@cacheByName
def applyOnsetDiffQNote3(inSample, perfFeats):
   return (applyOnsetDiffQNote)

@cacheByName
def extractTempoRatio4(sample):
   #align last note off and assume first note is beat 1
   #possible solution:
   #   - Align last note onset
   #   - Align last note off
   #   - Best align score and perf, minimize onset diff
   scoreLength = sample['score'].flat.notes.offsetMap[-1]['offset'] #Align the last note onset
   scoreLength += sample['score'].flat.notes[-1].duration.quarterLength
   weakStartOffset = getWeakStartOffset(sample) + 1 #first note is beat 1 
   perfLength = sample['perf'].flat.notes.offsetMap[-1]['offset'] 
   perfLength += sample['score'].flat.notes[-1].duration.quarterLength
   #perfStartOffset = sample['perf'].flat.notes.offsetMap[0]['offset'] 
   perfStartOffset = 0
   return (perfLength - perfStartOffset) / (scoreLength - weakStartOffset)

@cacheByName
def extractOnsetDiffQNote4(sample):
   scoreOffsets = [s['offset'] for s in sample['score'].flat.notes.offsetMap]
   perfOffsets = [p['offset'] for p in sample['perf'].flat.notes.offsetMap]
   perfStartOffset = 0

   ratio = extractTempoRatio4(sample)
   normalizedPerfOffsets= [(p - perfStartOffset) / ratio for p in perfOffsets]

   weakStartOffset = getWeakStartOffset(sample)
   shiftedPerfOffsets = map(lambda x: x + weakStartOffset, normalizedPerfOffsets) 

   logging.printDebug("scoreOffsets:")
   logging.printDebug(scoreOffsets)
   logging.printDebug("perfOffsets:")
   logging.printDebug(perfOffsets)
   logging.printDebug("shiftedPerfOffsets:")
   logging.printDebug(shiftedPerfOffsets)
   logging.printDebug("normalizedPerfOffsets:")
   logging.printDebug(normalizedPerfOffsets)
   
   offsetDiff = [ s - p for s, p in zip(scoreOffsets, shiftedPerfOffsets)]
   return offsetDiff

@cacheByName
def applyOnsetDiffQNote4(inSample, perfFeats):
   return (applyOnsetDiffQNote)

@cacheByName
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
   #if config.DEBUG:
      #for s, p in zip(scoreNotes, perfNotes):
         #logging.printDebug('s duration: '+ str(s.duration.quarterLength))
         #logging.printDebug('p duration: '+ str(p.duration.quarterLength))
   # maybe we should use (p-s)/s
   durationPercents = [p.duration.quarterLength / s.duration.quarterLength 
                       for s, p in zip(scoreNotes, perfNotes)]
   return durationPercents

def applyDurationPercent(inSample, perfFeats):
   outScore = inSample['score']
   notes = outScore.flat.notes
   durationPercents = perfFeats['DurationPercent']
   for durationPercent, note in zip(durationPercents, notes):
      outDuration = note.duration.quarterLength * durationPercent
      #logging.printDebug(outDuration)
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
