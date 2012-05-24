function exprScores = playRegression(scores, param, features);
   settings
   %features layer: features, scores, notes
%   currFeat = 0;
   performParam = {};
   assert(length(features) == size(param, 1), 'feature num is different in analyzed score and model param, please clear all intermediate data and rerun.');
   for featNo= 1:size(param,1)
      realPerfNo= NextUsedPerf;
      for perfNo= 1:size(param,2)
         performParam = {};
         realPerfNo.getNext;
%         if debug_mode
%            disp(realPerfNo.currPerf)
%         end
         for scoreNo = 1: length(features{featNo}) %num of scores
            %for featNo  = 1: length(features)
               %evaluate performance parameters
            performParam{end +1 }= polyval(param{featNo, perfNo},features{featNo}{scoreNo});
%            if debug_mode
%               disp(performParam{end})
%            end
               %apply parameter to score
   %         currFeat = getNextUsedFeat(currFeat);
            %assert(featNo == length(features), 'Features matrix reached the end before all features are evaluated');
            %break;
         end
         scores = applyPerf(realPerfNo.currPerf, scores, performParam);
      end
   end
   exprScores = scores;
end
