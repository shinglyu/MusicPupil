function feature = getFeat(featNo, samples, scores);
   if featNo == 1
      feature = getPosInPhrase(scores);
   elseif featNo == 2
      %do nothing
   else
      warning('No such feature!')
   end
end
