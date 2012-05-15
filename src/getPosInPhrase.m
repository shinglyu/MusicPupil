%get the position (%) of notes in phrases
function posInPhrase= getPosInPhrase(scores);
   settings
   for i = 1: length(scores)
      if debug_mode
         disp(i)
      end
      totalDuration = scores{i}(end, 6) + scores{i}(end, 7);
      posInPhrase{i} = scores{i}(:, 6) ./ totalDuration; %unit: % /100
   end
end
