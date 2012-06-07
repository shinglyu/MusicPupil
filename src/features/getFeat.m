function feature = getFeat(featNo, scores, metadata);
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
   elseif featNo == 7
      feature = getRelaDurationPrev(scores);
   elseif featNo == 8
      feature = getRelaDurationNext(scores);
   elseif featNo == 9
      feature = getMetricalPos(scores, metadata);
   else
      warning('No such feature!')
   end
end
