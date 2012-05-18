%get the time bias of human played sample from the score
function timeBias= getTimeBias(samples, scores);
   for i = 1: length(samples)
      %timeBias{i} = samples{i}(:,6) - scores{i}(:,6); %unit in sec
      %timeBias{i} = (samples{i}(:,6) - scores{i}(:,6))/(scores{i}(end,6) + scores{i}(end, 6)); %unit in sec
      timeBias{i} = samples{i}(:,1) - scores{i}(:,1); %unit in sec
   end
end
