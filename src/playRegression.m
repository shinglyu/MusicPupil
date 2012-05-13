function exprScores = playRegression(scores, param, features);
   %features layer: features, scores, notes
%   currFeat = 0;
   performParam = {};
   for featNo= 1:length(features)
      for scoreNo = 1: length(features{featNo}) %num of scores
         %for featNo  = 1: length(features)
            %evaluate performance parameters
         performParam{end+1}= polyval(param{featNo},features{featNo}{scoreNo});
            %apply parameter to score
%         currFeat = getNextUsedFeat(currFeat);
      end 
      perfNo= NextUsedPerf;
      perfNo.getNext;
      while ~perfNo.isEnd
         %assert(featNo == length(features), 'Features matrix reached the end before all features are evaluated');
         %break;
         scores = applyPerf(perfNo.currPerf, scores, performParam);
         perfNo.getNext;
      end
   end
   exprScores = scores;
end
