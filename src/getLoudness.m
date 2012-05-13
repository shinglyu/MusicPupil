%get the loudness of human played sample from the score
function loudness= getLoudness(samples, scores);
   for i = 1: length(samples)
      loudness{i} = samples{i}(:,5) - scores{i}(:,5); %unit in sec
      %loudness{i} = samples{i}(:,1) - scores{i}(:,1); %unit in sec
   end
end
