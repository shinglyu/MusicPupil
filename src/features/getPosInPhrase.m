%get the position (%) of notes in phrases
function posInPhrase= getPosInPhrase(scores);
   settings
   for i = 1: length(scores)
      if debug_mode
         disp(i)
      end
      totalDuration = scores{i}(end, ONSET_SEC) + scores{i}(end, DURATION_SEC);
      posInPhrase{i} = scores{i}(:, ONSET_SEC) ./ totalDuration; %unit: % /100
   end
end
