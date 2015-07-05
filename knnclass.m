function [datastruct]= knnclass(n,k,final,label)
%label=load('wulsinknnlabel.mat');
%label=label.label;
%final=load('pca3timesenergy+permentrop.mat');
%final=final.score;
%final=final(:,1:67);
L=size(final,1);
B=size(final,2);
C=size(label,2);
train_x=zeros(L-3600,B);
train_y=zeros(L-3600,C);
train_x(1:(n-1)*3600,:)=final(1:(n-1)*3600,:);
train_x((n-1)*3600+1:L-3600,:)=final((n)*3600+1:L,:);
train_y(1:(n-1)*3600,:)=label(1:(n-1)*3600,:);
train_y((n-1)*3600+1:L-3600,:)=label((n)*3600+1:L,:);
test_y=label((n-1)*3600+1:(n)*3600,:);
test_x=final((n-1)*3600+1:(n)*3600,:);

Mdl = fitcknn(train_x,train_y,'BreakTies','nearest','NumNeighbors',k);
pred_label = predict(Mdl,test_x);
pred=find(pred_label==1);
act=find(test_y==1);
common=numel(intersect(pred,act));
datastruct.common=common;
datastruct.pred=pred;
datastruct.act=act;
end