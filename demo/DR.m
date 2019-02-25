function [Ytest] = DR(train_data, train_p_target,  test_data, test_target, optmParameter)

max_iter = optmParameter.maxIter;
t = optmParameter.t;
lambda = optmParameter.lambda;
beta = optmParameter.beta;

par = mean(pdist(train_data));
ker = 'rbf';

l = size(test_target,1);
%Aeq = ones(l,1)';
beq = 1.07;
opts = optimoptions('quadprog',...
    'Algorithm','interior-point-convex','Display','off');
H = sparse(eye(l,l));
P = train_p_target';
sp = cell(max_iter+1, 1);
sp{1,1} = P;

for iter = 1:max_iter
    [Q, ~] = kernelRidgeRegression(train_data, P, test_data, beta, par, ker);
    [P] = solveQP(train_p_target', Q, H, beq, opts, t,lambda);
end

[~, Ytest] = kernelRidgeRegression(train_data, P, test_data, beta, par, ker);

%[accuracy] = CalAccuracy(Ytest, test_target);

end