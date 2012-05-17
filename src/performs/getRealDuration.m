%get the nhhotes in phrases
function dur = getRealDuration(samples, scores);
   for i = 1: length(samples)
      dur{i} = samples{i}(:,2)./scores{i}(:, 2); %unit: multiple to score 
   end
end
