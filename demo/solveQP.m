function [P] = solveQP(Y, Q, H, beq, opts, t,lambda)
%% solve m QP problems
[m, l] = size(Q);
P = zeros(m, l);

for i = 1:m
    lb=Y(i,:)';
    ub=Y(i,:)';
    lb(find(lb==1))=0;
    %ub(find(ub==1))=1;
    indicesOfCandidates = find(Y(i,:)==1);
    Aeq=sparse(l,1)';
    Aeq(indicesOfCandidates)=1;
    %Aeq = ones(l,1)';
    %%%
    %thr = (max(Q(i,indicesOfCandidates))+min(Q(i,indicesOfCandidates)))/2;
    thr=t-lambda;
    index1=(Q(i,indicesOfCandidates)>thr);
    index2=(Q(i,indicesOfCandidates)<thr);
    j1 = indicesOfCandidates(index1);
    j2 = indicesOfCandidates(index2);
    atp1 = zeros(l,1);
    atp2 = zeros(l,1);
    atp1(j1,1) = 1;
    atp2(j2,1) = 1;
    f = -Q(i,:)' - lambda*atp1+lambda*atp2;
    %Amtp = repmat(atp', l, 1);
    %Aneq = eye(l,l) - Amtp; % I*p - Amtp*p <= 0
    %bneq = zeros(l,1);
    
    x = quadprog(H, f, [], [], Aeq, beq, lb, ub, [], opts);
    if(isempty(x))
        fprintf('-------empty-------');
    end
    P(i,:) = x';
end

end

%%