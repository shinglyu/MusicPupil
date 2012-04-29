%create models
load('analyzeOutput.mat'); %features, performances

param = regressionModel(features, performances);

save('modelParams.mat', 'param')

