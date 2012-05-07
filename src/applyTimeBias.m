function outScores = applyTimeBias(inScores, performParam);
   assert(length(inScores) == length(performParam), ['inScore size ' num2str(length(inScores)) ' not equal to performParam size ' num2str(length(performParam))]);
   for scoreNo = 1: length(inScores)
      inScores{scoreNo}(6) = performParam{scoreNo}
   end
   outScores = inScores;
end
