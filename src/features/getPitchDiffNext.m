%get the pitch differnce between this note and the next note
function pitch= getPitchDiffNext(scores);
   for i = 1: length(scores)
      next= [scores{i}(2:end, 4); 0];
      pitch{i} = next - scores{i}(:, 4); %unit: % /100
      pitch{i} = pitch{i} .* (abs(pitch{i}) < abs(mean(pitch{i})*3));
   end
end
