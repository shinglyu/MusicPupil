function exprScores = playRule(scores, metadata)
settings

rules = UsedRule;
tmpScores = scores;

   while ~rules.isEnd
      tmpScores= rules.apply(tmpScores, metadata);
      rules.next();
   end
exprScores = tmpScores;
end

   
