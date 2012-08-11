function outScores= applyRule(ruleNo, inScores, metadata)
   if ruleNo == 1
      outScores = applyJazz01(inScores, metadata);
   elseif ruleNo == 2
      outScores = applyJazz02(inScores, metadata);
   elseif ruleNo == 3
      outScores = applyJazz03(inScores, metadata);
   elseif ruleNo == 4
      assert(1==2, 'Jazz Rule 4 not ready')
      outScores = applyJazz04(inScores, metadata);
   elseif ruleNo == 5
      outScores = applySwing(inScores, metadata);
   else
      assert(1==2, ['No such rule:' num2str(ruleNo)])
   end
end
