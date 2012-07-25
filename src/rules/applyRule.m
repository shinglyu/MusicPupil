function outScores= applyRule(ruleNo, inScores, metadata)
   if ruleNo == 1
      outScores = applyJazz01(inScores, metadata);
   elseif ruleNo == 2
   else
      warning('No such rule!')
      outScores = 0;
   end
end
