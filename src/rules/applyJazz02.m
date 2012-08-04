%from 2005_Modeling expressive music performance in jazz_Ramirez %RULE 2
function outScores = applyJazz02(inScores, metadata);

   duraMultiplier = 0.5;
   lengthenMult= 1.2;

   settings
   pos = getMetricalPos(inScores, metadata);
   outScores = inScores; %preallocate
   for scoreNo = 1: length(inScores)
      tmpScore = inScores{scoreNo};
      for noteNo = 1:size(inScores{scoreNo}, 1)-1
         assert(noteNo >= 1);
         thisNoteDura = inScores{scoreNo}(noteNo,DURATION_SEC);
         assert(noteNo+1 <= size(inScores{scoreNo}, 1));
         nextNoteDura = inScores{scoreNo}(noteNo+1,DURATION_SEC);
         %TODO is weak met
         if (thisNoteDura < duraMultiplier*nextNoteDura ) 
            tmpScore = alterDuration(tmpScore, noteNo, lengthenMult);
            %tmpScore(noteNo,DURATION_SEC) = tmpScore(noteNo,DURATION_SEC) * lengthenMultiplier;
         end
      end
      outScores{scoreNo} = tmpScore;
   end
end

