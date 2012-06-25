%get the metrical position (%) of notes 
function pos = getMetricalPos(scores, metadata)
   settings
   for scoreNo = 1: length(scores)
      if debug_mode
         disp(i)
      end
      %metadata.beatsInMeasure;
      %metadata.beatSize
      %metadata.measureStart;
      for noteNo = 1:size(scores{scoreNo}, 1)
         assert(metadata{scoreNo}.beatsInMeasure > 0, ['Bad beatsInMeasure for score ' num2str(scoreNo)] )
         %pos{scoreNo}(noteNo, 1) = mod(metadata{scoreNo}.measureStart+noteNo-1, metadata{scoreNo}.beatsInMeasure);
         pos{scoreNo}(noteNo,1) = mod(metadata{scoreNo}.measureStart + scores{scoreNo}(noteNo, ONSET_BEATS) - 1, metadata{scoreNo}.beatsInMeasure)+1;
      end
   end
end