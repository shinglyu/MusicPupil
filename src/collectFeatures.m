% collect single feature array into a single feature matrix
%features: feature matrix
%   each column is a single feature
%   row is each note
%featNames: names of features (cell)
%newFeatCell: feature cell array
%newFeatName: single feature name (string)
function features = collectFeatures(newFeatCell, features )
   tmpFeat = [];
   for i = 1:length(newFeatCell)
      tmpFeat= [tmpFeat; newFeatCell{i}];
   end
   features = [features tmpFeat]

end
