clc;
clear;
addpath('eval');
optmParameter.t   = 1;  
optmParameter.beta    = 0.05; 
optmParameter.lambda   = 0.5;  
optmParameter.maxIter = 50; % 
load('demo');
[test_outputs] = DR(train_data, train_p_target', test_data, test_target', optmParameter);
[HammingLoss,OneError,RankingLoss,Coverage,Average_Precision] = evaluation(test_outputs',test_target');






