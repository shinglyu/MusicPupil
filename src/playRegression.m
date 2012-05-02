function exprScores = playRegression(scores, param, features);
   %features layer: features, scores, notes
   currFeat = 1;
   for scoreNo = 1: length(features{1}) %num of scores
      for featNo  = 1: length(features)
         %evaluate performance parameters
         performParam{end+1}= polyval(param{featNo},features{featNo}{scoreNo});
      end 
      %TODO while ~useFeature(currFeat)
         currFeat = currFeat+1;
      end
      for scoreNo = 1: length(features{1}) %num of scores
         %apply parameter to score
         if currFeat == 1
            scores = applyTiamBiasscore()
         origScores =  
         %TODO:apply based on feature]
      end 
   end
      %exprScores = genScore (performParam, origScores)
end
