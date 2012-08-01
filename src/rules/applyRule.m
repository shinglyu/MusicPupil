function outScores= applyRule(ruleNo, inScores, metadata)
   if ruleNo == 1
      outScores = applyJazz01(inScores, metadata);
   elseif ruleNo == 2
   else
      assert(1==2, ['No such rule:' num2str(ruleNo)])
   end
end
