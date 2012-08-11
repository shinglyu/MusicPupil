function isStrong = isStrongBeat(score, metadata)
   if metadata.beatsInMeasure == 4
      isStrongs1 = getIsMetric({score}, {metadata}, 1);
      isStrongs3 = getIsMetric({score}, {metadata}, 3);
      isStrongs = {isStrongs1{1} + isStrongs3{1}};
   elseif metadata.beatsInMeasure == 3
      isStrongs = getIsMetric({score}, {metadata}, 1);
   else 
      isStrongs = getIsMetric({score}, {metadata}, 1);
   end
   isStrong = isStrongs{1};
end
      

      
      
