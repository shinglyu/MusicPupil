%from Jazz Arranging by david
%for now, the note which plays early extends to its original ending
%Early notes are select randomly by 'prob'
function outScores = applySwing(inScores, metadata);

   earlyTimeBeats= 0.5;
   prob = 0.5;

   settings
   %pos = getMetricalPos(inScores, metadata);
   outScores = inScores; %preallocate
   for scoreNo = 1: length(inScores)
      tmpScore = inScores{scoreNo};
      scoreLen = getNmatLengthSec(tmpScore);
      beatLen = getBeatInSec(tmpScore);
      isStrong = isStrongBeat(tmpScore, metadata{scoreNo});
      for noteNo = 1:size(inScores{scoreNo}, 1)
         %if ((pos{scoreNo}(noteNo) == 1) ||(pos{scoreNo}(noteNo) == 3))
         if (isStrong(noteNo))
            if (rand() > prob)
               tmpScore(noteNo, ONSET_SEC) =  tmpScore(noteNo, ONSET_SEC) - beatLen*earlyTimeBeats;
               tmpScore(noteNo, DURATION_SEC) = tmpScore(noteNo, DURATION_SEC) + beatLen * earlyTimeBeats;

            end
         end
      end
      outScores{scoreNo} = tmpScore;
   end
end

