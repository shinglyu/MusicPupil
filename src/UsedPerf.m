%please init currPerf with 0
%if return 0 == no next one
%function [featNo, currPerf] = getNextUsedFeat(currPerf)
classdef UsedPerf <handle
   properties
      currPerf = 0;
      isEnd = false;
   end
   methods
      %function bool = isEnd(obj)
      %   bool = obj.reachedEnd;
      %end
      function obj = UsedPerf(obj)
         obj.next;
      end

      function obj = next(obj)
         settings
         %disp(usePerform)

         if ((obj.currPerf+1) > length(usePerform))
            obj.currPerf = 0;
            obj.isEnd = true;
         else
            obj.currPerf = obj.currPerf +1;
            while  (~usePerform(obj.currPerf))
               if ((obj.currPerf+1) > length(usePerform))
                  obj.currPerf = 0;
                  obj.isEnd = true;
                  break;
               else
                  obj.currPerf = obj.currPerf +1;
               end
            end
         end
      end

      function feature = get(obj, samples, scores) 
         settings;
         feature = getPerform(obj.currPerf, samples, scores);
      end

      function outScores= apply(obj, inScores, performParam) 
         settings;
         outScores= applyPerf(obj.currPerf, inScores, performParam);
      end

   end
end
