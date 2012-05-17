function exprScores = playRegression(scores, param, features);
   %features layer: features, scores, notes
%   currFeat = 0;
   performParam = {};
   for perfNo= 1:length(param)
      for scoreNo = 1: size(features,2) %num of scores
         %for perfNo  = 1: length(features)
            %evaluate performance parameters
         performParam{end+1}= polyval(param{perfNo},features{perfNo}{scoreNo});
            %apply parameter to score
%         currFeat = getNextUsedFeat(currFeat);
      end 
      perfNo= NextUsedPerf;
      perfNo.getNext;
      while ~perfNo.isEnd
         %assert(perfNo == length(features), 'Features matrix reached the end before all features are evaluated');
         %break;
         scores = applyPerf(perfNo.currPerf, scores, performParam);
         perfNo.getNext;
      end
   end
   exprScores = scores;
end
