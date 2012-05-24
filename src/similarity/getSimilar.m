function simList = getSimilar(queryScore, sampScores, sampFnames)
   %addpath('..')
   settings
   if (debug_mode)
      tic;
   end
   rankList = zeros(length(sampScores), 1);
   %parfor scoreNo = 1: length(sampScores) 
   for scoreNo = 1: length(sampScores) 
      rank = calcRank(queryScore, sampScores{scoreNo});
      %collect ranks => to sql
      %rankList{1}[end +1] = sampFnames{scoreNo};
      %rankList{2}[end +1] = rank;
      rankList(scoreNo) = rank;
   end
   [sortedList, idx] = sort(rankList, 'descend');
   numSamples = floor(length(idx)*sampSize);
   assert(numSamples > 0, 'Sample size too small, no sample are selected. Consider using a larger sampSize.')
   for i = 1:numSamples
      simList{i} = sampFnames{idx(i)};
   end
   if (debug_mode)
      toc;
   end
end
