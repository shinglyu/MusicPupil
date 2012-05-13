function performParam= getPerform(performNo, samples, scores);
   if performNo == 1
      performParam = getTimeBias(samples, scores);
   elseif performNo == 2
      performParam = getLoudness(samples, scores);
   else
      warning('No such performance parameter!')
   end
end
