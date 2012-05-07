function exprScores = playRegression(scores, param, features);
   %features layer: features, scores, notes
   currFeat = 0;
   performParam = {};
   for featNo= 1:length(features)
      for scoreNo = 1: length(features{featNo}) %num of scores
         %for featNo  = 1: length(features)
            %evaluate performance parameters
         performParam{end+1}= polyval(param{featNo},features{featNo}{scoreNo});
            %apply parameter to score
         currFeat = getNextUsedFeat(currFeat);
      end 
      if currFeat == 0
         assert(featNo == length(features), 'Features matrix reached the end before all features are evaluated');
         break;
      elseif currFeat == 1
         scores = applyTimeBias(scores, performParam);
      else
         warning(sprintf('currFeat %d is not a valid feature number', currFeat));
      end
   end
   exprScores = scores
end
