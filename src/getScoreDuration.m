%get the nhhotes in phrases
function dur = getScoreDuration(scores);
   for i = 1: length(scores)
      dur{i} = scores{i}(:, 2); %unit: beats
   end
end
