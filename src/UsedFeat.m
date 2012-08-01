%please init currFeat with 0
%if return 0 == no next one
%function [featNo, currFeat] = getNextUsedFeat(currFeat)
classdef UsedFeat <handle
   properties
      currFeat = 0;
      isEnd = false;
   end
   methods
      %function bool = isEnd(obj)
      %   bool = obj.reachedEnd;
      %end
      function obj = UsedFeat(obj)
         obj.next;
      end

      function obj = next(obj)
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

      function feature = get(obj, scores, metadata) 
         settings;
         feature = getFeat(obj.currFeat, scores, metadata);
      end

   end
end
