%select only one score from a multi-score feature cell.
%the ouput is a feature cell with only one score
function singleFeature = selectScore(features, scoreNo);
   for featNo = 1:length(features)
      singleFeature{featNo} = {features{featNo}{scoreNo}};
   end
end

