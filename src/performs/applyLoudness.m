function outScores = applyLoudness(inScores, performParam);
   %assert(length(inScores) == length(performParam), ['inScore size ' num2str(length(inScores)) ' not equal to performParam size ' num2str(length(performParam))]);
   settings
   if debug_mode
      disp('loudness input')
      disp(inScores{1}(:,5))
   end
   MAX_LOUD = 127;
   for scoreNo = 1: length(inScores)
      %disp(size(inScores{scoreNo}(:,5)));
      %disp(size(performParam{scoreNo}));
      MAX_LOUD = 127;
      if max(performParam{scoreNo}) > MAX_LOUD
         inScores{scoreNo}(:,5) = performParam{scoreNo} / max(performParam{scoreNo}) * MAX_LOUD;
      else
         inScores{scoreNo}(:,5) = performParam{scoreNo};
      end
      
     % inScores{scoreNo}(:,5) = inScores{scoreNo}(:,5) + 10*performParam{scoreNo};
      %inScores{scoreNo}(:,1) = inScores{scoreNo}(:,1) + performParam{scoreNo};

      %inScores{scoreNo}(:,1) = inScores{scoreNo}(:,1) + rand(size(inScores{scoreNo}(:,1)))*3;
      %inScores{scoreNo}(:,5) = inScores{scoreNo}(:,5) + rand(size(inScores{scoreNo}(:,5)))*100;
   end
   outScores = inScores;

   if debug_mode
      disp('loudness output')
      disp(outScores{1}(:,5))
   end
end
