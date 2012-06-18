
function param = modelMultiRegress(features, performances)
   settings

   %polyOrder = 2; %order of polynoimial regression

   %if (size(features,2) > 1)
      %warning('Size of features is over one dimension. Only the first featrures are used');
   %end

   %for featNo = 1: size(features,2)
   %for perfNo = 1: size(performances,2)
   %prepare feature cell for mvregress input
   featCell = {};
   perfCount = size(performances, 2);
   for noteNo = 1:size(features,1)
      featCell{noteNo, 1} = [eye(perfCount) repmat(features(noteNo, :), perfCount, 1)];
   end

   param = mvregress(featCell, performances);
   if debug_mode
      disp(param)
   end
   %end
   %end

   save('modelParams.mat', 'param');
   
   %TODO
   if visualize
%      for featNo = 1: size(features,2)
%         for perfNo = 1: size(performances,2)
%            figNo = (featNo-1)*size(performances,2) + perfNo;
%            if debug_mode
%               disp([featNo perfNo figNo])
%            end
%            subplot(size(features, 2), size(performances, 2), figNo)
%            orderFeat = sort(features(:,featNo));
%            tmpPerform = polyval(param{featNo, perfNo},orderFeat );
%            %tmpPerform = polyval(param{i},features(:,1) );
%            %plot(features(:,1), performances(:,i), 'o', features(:,1), tmpPerform, '-');
%            plot(features(:,featNo), performances(:,perfNo), 'o', orderFeat, tmpPerform, '-');
%            xlabel(['Feature ' num2str(featNo)])
%            ylabel(['Performance Param ' num2str(perfNo)])
%
%            %plot(orderFeat, tmpPerform, '-');
%         end 
%      end 
   end

end
