function performParam= getPerform(performNo, samples, scores);
   if performNo == 1
      performParam = getTimeBias(samples, scores);
   elseif performNo == 2
      performParam = getLoudness(samples);
   elseif performNo == 3
      performParam = getRealDuration(samples, scores);
   elseif performNo == 4
      performParam = getRelaTimeBias(samples, scores);
   else
      warning('No such performance parameter!')
   end
end
