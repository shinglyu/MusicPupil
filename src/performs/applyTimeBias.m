function outScores = applyTimeBias(inScores, performParam);
   %assert(length(inScores) == length(performParam), ['inScore size ' num2str(length(inScores)) ' not equal to performParam size ' num2str(length(performParam))]);
   settings
   if debug_mode
      disp('time Bias input')
      disp(inScores{1}(:,1))
   end

   for scoreNo = 1: length(inScores)
      %disp(size(inScores{scoreNo}(:,6)));
      %disp(size(performParam{scoreNo}));
      %inScores{scoreNo}(:,6) = inScores{scoreNo}(:,6) + performParam{scoreNo};
      %inScores{scoreNo}(:,6) = max(inScores{scoreNo}(:,6), zeros(size(inScores{scoreNo}(:,6))));% no negatie onset time allowed
      inScores{scoreNo}(:,1) = inScores{scoreNo}(:,1) + performParam{scoreNo};
      inScores{scoreNo}(:,1) = max(inScores{scoreNo}(:,1), zeros(size(inScores{scoreNo}(:,1))));% no negatie onset time allowed
      %inScores{scoreNo}(:,1) = inScores{scoreNo}(:,1) + 10*performParam{scoreNo};
      %inScores{scoreNo}(:,1) = inScores{scoreNo}(:,1) + performParam{scoreNo};

      %inScores{scoreNo}(:,1) = inScores{scoreNo}(:,1) + rand(size(inScores{scoreNo}(:,1)))*3;
      %inScores{scoreNo}(:,6) = inScores{scoreNo}(:,6) + rand(size(inScores{scoreNo}(:,6)))*3;
   end
   outScores = inScores;

   if debug_mode
      disp('time bias output')
      disp(outScores{1}(:,1))
   end
end
