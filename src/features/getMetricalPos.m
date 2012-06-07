%get the metrical position (%) of notes 
function pos = getMetricalPos(scores, metadata)
   settings
   for i = 1: length(scores)
      if debug_mode
         disp(i)
      end
      %metadata.beatsInMeasure;
      %metadata.beatSize
      %metadata.measureStart;
      for j = 1:size(scores{i}, 1)
         pos{i}(j, 1) = mod(metadata{i}.measureStart+j-1), metadata{i}.beatsInMeasure);
      end
   end
end
