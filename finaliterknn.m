label=load('wulsinknnlabel.mat');
label=label.label;
%final=load('pca3timesenergy+permentrop.mat');
final=score(:,1:64);
%final=final(:,1:35);
L=size(final,1);
B=size(final,2);
C=size(label,2);
accknnn=cell(1,24);
for j=1:22
        %ds=knnclass(j,3);
        ds1=knnclass(j,5,final,label);
        %ds2=knnclass(j,10);
        %ds3=knnclass(j,15);
        accknnn{1,j}.act=ds1.act; 
        %accknnnormalize{1,j}.k3=ds.pred;
        accknnn{1,j}.k5=ds1.pred;
        accknnn{1,j}.common=ds1.common;
        %accknnnormalize{1,j}.k10=ds2.pred;
        %accknnnormalize{1,j}.k15=ds3.pred;
        j
end
train_x=zeros(L-3600,B);
train_y=zeros(L-3600,C);
train_x(1:78100,:)=final(1:78100,:);
train_x(78101:81700,:)=final(81701:85300,:);
train_y(1:78100,:)=label(1:78100,:);
train_y(78101:81700,:)=label(81701:85300,:);
test_y=label(78101:81700,:);
test_x=final(78101:81700,:);
Mdl = fitcknn(train_x,train_y,'BreakTies','nearest','NumNeighbors',5);
pred_label = predict(Mdl,test_x);
pred=find(pred_label==1);
act=find(test_y==1);
common=numel(intersect(pred,act));
accknnn{1,23}.act=act;    
accknnn{1,23}.k5=pred;
accknnn{1,23}.common=common;

train_x=zeros(L-3600,B);
train_y=zeros(L-3600,C);
train_x(1:81700,:)=final(1:81700,:);
train_y(1:81700,:)=label(1:81700,:);
test_y=label(81701:85300,:);
test_x=final(81701:85300,:);
Mdl = fitcknn(train_x,train_y,'BreakTies','nearest','NumNeighbors',5);
pred_label = predict(Mdl,test_x);
pred=find(pred_label==1);
act=find(test_y==1);
common=numel(intersect(pred,act));
accknnn{1,24}.act=act;    
accknnn{1,24}.k5=pred;
accknnn{1,24}.common=common;
%save('pat12knnfreq1secnormalize.mat','accknnnormalize');
