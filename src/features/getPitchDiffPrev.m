%get the pitch differnce between this note and the previous note
function pitch= getPitchDiffPrev(scores);
   for i = 1: length(scores)
      prev = [0; scores{i}(1:end-1, 4)];
      pitch{i} = scores{i}(:, 4) - prev; %unit: % /100
      pitch{i} = pitch{i} .* (abs(pitch{i}) < abs(mean(pitch{i})*3));
   end
end
