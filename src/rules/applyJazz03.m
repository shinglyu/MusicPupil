%from 2005_Modeling expressive music performance in jazz_Ramirez 
%RULE 2
%if the next silence is longer than average half note duation, lengthen
function outScores = applyJazz03(inScores, metadata);

   lengthenMult= 1.2;

   settings
   %pos = getMetricalPos(inScores, metadata);
   outScores = inScores; %preallocate
   for scoreNo = 1: length(inScores)
      tmpScore = inScores{scoreNo};

      totalTime = inScores{scoreNo}(end, ONSET_SEC) + inScores{scoreNo}(end, DURATION_SEC);
      beatDuration = totalTime / size(inScores{scoreNo}, 1);

      for noteNo = 1:size(inScores{scoreNo}, 1)-1
         assert(noteNo >= 1);
         thisNoteOnset = inScores{scoreNo}(noteNo,ONSET_SEC);
         thisNoteDura = inScores{scoreNo}(noteNo,DURATION_SEC);
         assert(noteNo+1 <= size(inScores{scoreNo}, 1));
         nextNoteOnset = inScores{scoreNo}(noteNo+1,ONSET_SEC);
         %TODO is weak met
         if (nextNoteOnset - (thisNoteOnset + thisNoteDura) > beatDuration/2)
            tmpScore = alterDuration(tmpScore, noteNo, lengthenMult);
            %tmpScore(noteNo,DURATION_SEC) = tmpScore(noteNo,DURATION_SEC) * lengthenMultiplier;
         end
      end
      outScores{scoreNo} = tmpScore;
   end
end

