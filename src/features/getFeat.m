function feature = getFeat(featNo, scores);
   if featNo == 1
      feature = getPosInPhrase(scores);
   elseif featNo == 2
      feature = getPitch(scores);
   elseif featNo == 3
      feature = getRelaPitch(scores);
   elseif featNo == 4
      feature = getScoreDuration(scores);
   elseif featNo == 5
      feature = getPitchDiffPrev(scores);
   elseif featNo == 6
      feature = getPitchDiffNext(scores);
   else
      warning('No such feature!')
   end
end
