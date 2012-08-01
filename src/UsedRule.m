%please init currRule with 0
%if return 0 == no next one
%function [featNo, currRule] = getNextUsedRule(currRule)
classdef UsedRule <handle
   properties
      currRule = 0;
      isEnd = false;
   end
   methods
      %function bool = isEnd(obj)
      %   bool = obj.reachedEnd;
      %end
      function obj = UsedRule(obj)
         obj.next;
      end

      function obj = next(obj)
         settings
         %disp(useRule)

         if ((obj.currRule+1) > length(useRule))
            obj.currRule = 0;
            obj.isEnd = true;
         else
            obj.currRule = obj.currRule +1;
            while  (~useRule(obj.currRule))
               if ((obj.currRule+1) > length(useRule))
                  obj.currRule = 0;
                  obj.isEnd = true;
                  break;
               else
                  obj.currRule = obj.currRule +1;
               end
            end
         end
      end

      function outScores = apply(obj, inScores, metadata) 
         settings;
         outScores = applyRule(obj.currRule, inScores, metadata) ;
      end

   end
end
