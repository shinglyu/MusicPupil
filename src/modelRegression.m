function param = modelRegression(features, performances)
   settings

   polyOrder = 2; %order of polynoimial regression

   if (size(features,2) > 1)
      warning('Size of features is over one dimension. Only the first featrures are used');
   end

   for i = 1: size(performances,2)
      param{i} = polyfit(features(:,1), performances(:,i), 2);
   end

   save('modelParams.mat', 'param');
   
   if visualize
      for i = 1: size(param,2)
         figure
         orderFeat = sort(features(:,1));
         tmpPerform = polyval(param{i},orderFeat );
         %tmpPerform = polyval(param{i},features(:,1) );
         %plot(features(:,1), performances(:,i), 'o', features(:,1), tmpPerform, '-');
         plot(features(:,1), performances(:,i), 'o', orderFeat, tmpPerform, '-');
         xlabel(['Feature'])
         ylabel(['Performance Param'])

         %plot(orderFeat, tmpPerform, '-');
      end 
   end

end
