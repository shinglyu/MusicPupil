% collect single feature array into a single feature matrix
%features: feature matrix
%   each column is a single feature
%   row is each note
%featNames: names of features (cell)
%newFeatCell: feature cell array
%newFeatName: single feature name (string)
function concatedFeats= concatinateFeatures(features )
   settings

   concatedFeats= [];
%   if debug_mode
%      disp(size(features))
%   end
   for featNo = 1:length(features)
      tmpFeat = [];
%      if debug_mode
%         disp(size(features{featNo}))
%      end
      for scoreNo = 1:length(features{featNo})
%         if debug_mode
%            disp(size(features{featNo}{scoreNo}))
%         end
         tmpFeat= [tmpFeat; features{featNo}{scoreNo}];
%         if debug_mode
%            disp(size(tmpFeat))
%         end
      end
      concatedFeats= [concatedFeats tmpFeat];
%      if debug_mode
%         disp(size(concatedFeats))
%      end
   end

end
