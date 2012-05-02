%create models
load('sample.mat'); %features, performances

concatedFeats = concatinateFeatures(features);
concatedPerforms = concatinateFeatures(performParams);

if useRegression
   param = modelRegression(concatedFeats, concatedPerforms);
end

save('modelParams.mat', 'param')

