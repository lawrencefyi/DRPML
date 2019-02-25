function [HammingLoss,OneError,RankingLoss,Coverage,Average_Precision] = evaluation(Outputs,test_target)
[l,m]=size(Outputs);
Pre_Labels=zeros(l,m);
% [maxOut,~]=max(Outputs,[],1);
% [minOut,~]=min(Outputs,[],1);
% thr=(maxOut+minOut)/2;
% thrMatrix=repmat(thr,l,1);
% Pre_Labels=double((Outputs>thrMatrix));
 %Pre_Labels(find(Pre_Labels==0))=-1;
 %test_target(find(test_target==0))=-1;
 Pre_Labels(find(Outputs<0))=-2;
 Pre_Labels(find(Outputs>0))=1;
 %test_target(find(test_target==2))=1;
%test_target(find(test_target==-3))=-1;
%%%%%%%%%%%%%
HammingLoss=Hamming_loss(Pre_Labels,test_target);
OneError=One_error(Outputs,test_target);
RankingLoss=Ranking_loss(Outputs,test_target);
Coverage=coverage(Outputs,test_target);
Average_Precision=Average_precision(Outputs,test_target);
end

