%get the pitch  notes in phrases
function pitch= getPitch(scores);
   for i = 1: length(scores)
      pitch{i} = scores{i}(:, 4); %unit: % /100
   end
end
