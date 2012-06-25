%create models
function modelParam = modeling(features, performParams)
   settings
%   load('sample.mat'); %features, performances

   fprintf('Modeling...\n')
   concatedFeats = concatinateFeatures(features);
   concatedPerforms = concatinateFeatures(performParams);

   modelNo = getModelNo();
   if modelNo == 1 
      modelParam = modelRegression(concatedFeats, concatedPerforms);
   elseif modelNo == 2
      modelParam = modelSingleRegress(concatedFeats, concatedPerforms);
   elseif modelNo == 3
      modelParam = modelMultiRegress(concatedFeats, concatedPerforms);
   else
      warning('No modeling method selected!');
   end

   %save('modelParam.mat', 'modelParam')
   disp('DONE')
end
