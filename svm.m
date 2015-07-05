function [pred,act]=svm(n)
label=load('wulsinknnlabel.mat');
label=label.label;
final=load('pat12freq1sec.mat');
final=final.final_data;
L=size(final,1);
B=size(final,2);
C=size(label,2);
finale=zeros(L-3600,B);
labele=zeros(L-3600,C);
finale(1:(n-1)*3600,:)=final(1:(n-1)*3600,:);
finale((n-1)*3600+1:L-3600,:)=final((n)*3600+1:L,:);
labele(1:(n-1)*3600,:)=label(1:(n-1)*3600,:);
labele((n-1)*3600+1:L-3600,:)=label((n)*3600+1:L,:);
finale=sparse(finale);
model=svmtrain(labele,finale,'-s 0 -c 1 -t 2 -g 0.1 -h 0 -b 1');
test_l=label((n-1)*3600+1:(n)*3600,:);
test_p=final((n-1)*3600+1:(n)*3600,:);
test_p=sparse(test_p);
[predict_label_L, accuracy_L, dec_values_L] = svmpredict(test_l, test_p, model,'-b 1');
pred=find(predict_label_L==1)
act=find(test_l==1)
end

