%get the pitch  notes in phrases
function pitch= getRelaPitch(scores);
   for i = 1: length(scores)
      high = max(scores{i}(:, 4));
      low= min(scores{i}(:, 4));
      range = high - low;
      pitch{i} = (scores{i}(:, 4) - ones(size(scores{i}(:, 4)))*low)/range; %unit: % /100
   end
end
