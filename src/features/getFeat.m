function feature = getFeat(featNo, scores);
   if featNo == 1
      feature = getPosInPhrase(scores);
   elseif featNo == 2
      feature = getPitch(scores);
   elseif featNo == 3
      feature = getRelaPitch(scores);
   elseif featNo == 4
      feature = getScoreDuration(scores);
   else
      warning('No such feature!')
   end
end
