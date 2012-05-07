%please init currFeat with 0
%if return 0 == no next one
%function [featNo, currFeat] = getNextUsedFeat(currFeat)
function currFeat = getNextUsedFeat(currFeat)
   settings
   %disp(useFeature)

   if ((currFeat+1) > length(useFeature))
      currFeat = 0;
   else
      currFeat = currFeat +1;
      while  (~useFeature(currFeat))
         if ((currFeat+1) > length(useFeature))
            currFeat = 0;
            break;
         else
            currFeat = currFeat +1;
         end
      end
   end

end
