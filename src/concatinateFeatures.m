% collect single feature array into a single feature matrix
%features: feature matrix
%   each column is a single feature
%   row is each note
%featNames: names of features (cell)
%newFeatCell: feature cell array
%newFeatName: single feature name (string)
function concatedFeats= concatinateFeatures(features )
   concatedFeats= [];
   for featNo = 1:length(features)
      tmpFeat = [];
      for scoreNo = 1:length(features{featNo})
         tmpFeat= [tmpFeat; features{featNo}{scoreNo}];
      end
      concatedFeats= [concatedFeats tmpFeat];
   end

end
