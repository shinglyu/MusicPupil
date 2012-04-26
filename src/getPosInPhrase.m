%get the position (%) of notes in phrases
function posInPhrase= getPosInPhrase(scores);
   for i = 1: length(scores)
      totalDuration = scores{i}(end, 6) + scores{i}(end, 7);
      posInPhrase{i} = scores{i}(:, 6) ./ totalDuration; %unit: % /100
   end
end
