%please init currPerf with 0
%if return 0 == no next one
%function [featNo, currPerf] = getNextUsedFeat(currPerf)
classdef NextUsedPerf <handle
   properties
      currPerf = 0;
      isEnd = false;
   end
   methods
      %function bool = isEnd(obj)
      %   bool = obj.reachedEnd;
      %end

      function obj = getNext(obj)
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
   end
end