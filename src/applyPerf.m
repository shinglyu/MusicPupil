function outScores= applyPerf(performNo, inScores, performParam)
   if performNo == 1
      outScores = applyTimeBias(inScores, performParam);
   elseif performNo == 2
      outScores = applyLoudness(inScores, performParam);
   else
      warning('No such performance parameter!')
   end
end
