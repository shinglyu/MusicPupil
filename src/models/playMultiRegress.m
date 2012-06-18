function exprScores = playMultiRegress(scores, param, features);
   settings
   %features layer: features, scores, notes
%   currFeat = 0;
   performParam = {};
   %Calculate the Y values from above
   featCount = size(features,2);
   perfCount = size(param, 2) - featCount;

   ptb = bsxfun(@times,predictors,b(4:9)'); %predictors times b values for independent var    iables
   ptb = sum(ptb,2); %sum columnwise to get the value
   Y   = bsxfun(@plus,b(1:3)',ptb); %add to intercepts
   
   %for featNo= 1:size(param,1)
      realPerfNo= NextUsedPerf;
      for perfNo= 1:size(param,2)
         performParam = {};
         realPerfNo.getNext;
%         if debug_mode
%            disp(realPerfNo.currPerf)
%         end
         for scoreNo = 1: length(features{1}) %num of scores
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
   %end
   exprScores = scores;
end
