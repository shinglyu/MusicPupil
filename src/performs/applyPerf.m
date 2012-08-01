function outScores= applyPerf(performNo, inScores, performParam)
   if performNo == 1
      outScores = applyTimeBias(inScores, performParam);
   elseif performNo == 2
      outScores = applyLoudness(inScores, performParam);
   elseif performNo == 3
      outScores = applyRealDuration(inScores, performParam);
   elseif performNo == 4
      outScores = applyRelaTimeBias(inScores, performParam);
   else
      %warning('No such performance parameter!')
      assert(1==2, ['No such performance parameter:' num2str(performNo)])
   end
end
