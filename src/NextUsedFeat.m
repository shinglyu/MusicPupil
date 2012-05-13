%please init currFeat with 0
%if return 0 == no next one
%function [featNo, currFeat] = getNextUsedFeat(currFeat)
classdef NextUsedFeat <handle
   properties
      currFeat = 0;
      isEnd = false;
   end
   methods
      %function bool = isEnd(obj)
      %   bool = obj.reachedEnd;
      %end

      function obj = getNext(obj)
         settings
         %disp(useFeature)

         if ((obj.currFeat+1) > length(useFeature))
            obj.currFeat = 0;
            obj.isEnd = true;
         else
            obj.currFeat = obj.currFeat +1;
            while  (~useFeature(obj.currFeat))
               if ((obj.currFeat+1) > length(useFeature))
                  obj.currFeat = 0;
                  obj.isEnd = true;
                  break;
               else
                  obj.currFeat = obj.currFeat +1;
               end
            end
         end
      end
   end
end
