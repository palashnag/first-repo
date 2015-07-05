function [datastruct]= nnet(n)
addpath('E:\Jeevomics\DeepLearnToolbox-master\NN');
label=load('wulsinlabel12.mat');
label=label.label;
final=load('pat12freq1sec.mat');
final=final.final_data;
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

rand('state',0);
nn = nnsetup([B 10 C]);
nn.activation_function = 'ReLU';    %  ReLU activation function
nn.learningRate = 0.01;                %  Sigm require a lower learning rate
nn.dropoutFraction = 0.0;   %  Dropout fraction 
nn.weightPenaltyL2 = 0.01;  %  L2 weight decay
nn.output              = 'softmax';    %  use softmax output
opts.numepochs =  15;   %  Number of full sweeps through data
opts.batchsize = 4;  %  Take a mean gradient step over this many samples

[nn, L] = nntrain(nn, train_x, train_y, opts);
[er, bad] = nntest(nn, test_x, test_y);
pred_labels = nnpredict(nn, test_x);
pred=find(pred_labels==2);
[dummy, expected] = max(test_y,[],2);
act=find(expected==2);
common=numel(intersect(pred,act));
assert(er < 0.1, 'Too big error');
datastruct.common=common;
datastruct.pred=pred;
datastruct.act=act;
end