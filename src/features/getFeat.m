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
   elseif featNo == 10 
      feature = getIsMetric(scores, metadata, 1);
   elseif featNo == 11 
      feature = getIsMetric(scores, metadata, 2);
   elseif featNo == 12 
      feature = getIsMetric(scores, metadata, 3);
   elseif featNo == 13 
      feature = getIsMetric(scores, metadata, 4);
   elseif featNo == 14 
      feature = getIsMetric(scores, metadata, 5);
   elseif featNo == 15 
      feature = getIsMetric(scores, metadata, 6);
   else
      warning('No such feature!')
   end
end
