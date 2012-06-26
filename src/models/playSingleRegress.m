function exprScores = playSingleRegress(scores, param, features);
   settings
   %features layer: features, scores, notes
%   currFeat = 0;
   performParam = {};
   %Calculate the Y values from above
   %featCount = size(features,2);
   %perfCount = size(param, 2) - featCount;

   
   %for featNo= 1:size(param,1)
      realPerfNo= NextUsedPerf;
      for perfNo= 1:size(param,2)
         performParam = {};
         realPerfNo.getNext;
%         if debug_mode
%            disp(realPerfNo.currPerf)
%         end
         for scoreNo = 1: length(features{1}) %num of scores
            singleFeat = selectScore(features, scoreNo);
            concatedFeats = concatinateFeatures(singleFeat);
            concatedFeats = [concatedFeats ones(size(concatedFeats, 1), 1)]; %add const to ensure R-square is well defined
            %for featNo  = 1: length(features)
               %evaluate performance parameters
            scoreLength = size(concatedFeats, 1);
            paramMat = repmat(param{perfNo}',scoreLength, 1);
            assert(sum(size(paramMat) == size(concatedFeats))==2);
            performParam{end +1 }= sum(paramMat .* concatedFeats, 2);
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
