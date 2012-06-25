function param = modelSingleRegress(features, performances)
   settings

   %polyOrder = 2; %order of polynoimial regression

   %if (size(features,2) > 1)
      %warning('Size of features is over one dimension. Only the first featrures are used');
   %end

   %for featNo = 1: size(features,2)
   %for perfNo = 1: size(performances,2)
   %prepare feature cell for mvregress input
   features = [features ones(size(features, 1), 1)]; %add const to ensure R-square is well defined
   for perfNo = 1: size(performances,2)
      [param{perfNo}, paramInt, r, rInt, stats] = regress(performances(:,perfNo), features );
      disp(['===Perfromance Feature No.' num2str(perfNo) '==='])
      disp(['R2-statics: ' num2str(stats(1))]);
      disp(['F-statics: ' num2str(stats(2))]);
      disp(['p-value: ' num2str(stats(3))]);
      disp(['estimate of error var: ' num2str(stats(3))]);
   end

   %disp(['R2-statics: ' num2str(stats(1))]);
   %disp(['F-statics: ' num2str(stats(2))]);
   %disp(['p-value: ' num2str(stats(3))]);
   %disp(['estimate of error var: ' num2str(stats(3))]);

   if debug_mode
      disp(param)
      disp(param{1})
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
