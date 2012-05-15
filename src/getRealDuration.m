%get the nhhotes in phrases
function dur = getRealDuration(samples, scores);
   for i = 1: length(samples)
      dur{i} = samples{i}(:,7)./scores{i}(:, 7); %unit: multiple to score 
   end
end
