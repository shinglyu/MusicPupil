%is the not on metric n pos?
function isPos = getIsMetric(scores, metadata, metricNo)
   settings
   pos = getMetricalPos(scores, metadata);
   for scoreNo = 1:length(pos)
      isPos{scoreNo} = (pos{scoreNo} == metricNo);
   end
end
