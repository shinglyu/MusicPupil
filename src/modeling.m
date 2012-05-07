%create models
settings
load('sample.mat'); %features, performances

disp('Modeling...')
concatedFeats = concatinateFeatures(features);
concatedPerforms = concatinateFeatures(performParams);

if useRegression
   modelParam = modelRegression(concatedFeats, concatedPerforms);
end

save('modelParam.mat', 'modelParam')
disp('DONE')
