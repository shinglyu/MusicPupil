function outScores = applyLoudness(inScores, performParam);
   assert(length(inScores) == length(performParam), ['inScore size ' num2str(length(inScores)) ' not equal to performParam size ' num2str(length(performParam))]);
   for scoreNo = 1: length(inScores)
      %disp(size(inScores{scoreNo}(:,6)));
      %disp(size(performParam{scoreNo}));
      inScores{scoreNo}(:,5) = inScores{scoreNo}(:,5) + performParam{scoreNo};
     % inScores{scoreNo}(:,6) = inScores{scoreNo}(:,6) + 10*performParam{scoreNo};
      %inScores{scoreNo}(:,1) = inScores{scoreNo}(:,1) + performParam{scoreNo};

      %inScores{scoreNo}(:,1) = inScores{scoreNo}(:,1) + rand(size(inScores{scoreNo}(:,1)))*3;
      %inScores{scoreNo}(:,6) = inScores{scoreNo}(:,6) + rand(size(inScores{scoreNo}(:,6)))*3;
   end
   outScores = inScores;
end
