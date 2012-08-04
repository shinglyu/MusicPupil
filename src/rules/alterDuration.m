function outScore = alterDuration(inScore, noteNo, multiplier)
   outScore = inScore;
   settings
   outScore(noteNo, DURATION_SEC) = inScore(noteNo, DURATION_SEC) * multiplier;
   if (multiplier > 1)
      durationDiff = inScore(noteNo, DURATION_SEC) * (multiplier - 1);
      outScore(noteNo + 1, ONSET_SEC) = inScore(noteNo + 1, ONSET_SEC) + durationDiff;
      outScore(noteNo + 1, DURATION_SEC) = inScore(noteNo + 1, DURATION_SEC) - durationDiff;
   end

end
