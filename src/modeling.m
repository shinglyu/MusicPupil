%create models
function modelParam = modeling(features, performParams)
   settings
%   load('sample.mat'); %features, performances

   fprintf('Modeling...')
   concatedFeats = concatinateFeatures(features);
   concatedPerforms = concatinateFeatures(performParams);

   if useRegression
      modelParam = modelRegression(concatedFeats, concatedPerforms);
   else
      warning('No modeling method selected!');
   end

   %save('modelParam.mat', 'modelParam')
   disp('DONE')
end
