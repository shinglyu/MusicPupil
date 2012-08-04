%from 2005_Modeling expressive music performance in jazz_Ramirez
%RULE 1
function outScores = applyJazz01(inScores, metadata);

   duraMultiplier = 2;
   shortenMultiplier = 0.5;

   settings
   pos = getMetricalPos(inScores, metadata);
   outScores = inScores; %preallocate
   for scoreNo = 1: length(inScores)
      tmpScore = inScores{scoreNo};
      for noteNo = 2:size(inScores{scoreNo}, 1)-1
         assert(noteNo-1 >= 1);
         prevNoteDura = inScores{scoreNo}(noteNo-1,DURATION_SEC);
         thisNoteDura = inScores{scoreNo}(noteNo,DURATION_SEC);
         assert(noteNo+1 <= size(inScores{scoreNo}, 1));
         nextNoteDura = inScores{scoreNo}(noteNo+1,DURATION_SEC);
         %TODO is weak met
         if (thisNoteDura < duraMultiplier*nextNoteDura ) && (thisNoteDura < duraMultiplier*prevNoteDura)
            tmpScore = alterDuration(tmpScore, noteNo, shortenMultiplier);
            %tmpScore(noteNo,DURATION_SEC) = tmpScore(noteNo,DURATION_SEC) * shortenMultiplier;
         end
      end
      outScores{scoreNo} = tmpScore;
   end
end

