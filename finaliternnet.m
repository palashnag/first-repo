accnnet=cell(1,22);
for j=1:22
        accnnet{1,j}=nnet(j);
        j
end
save('pat12nnetwulsin.mat','accnnet');