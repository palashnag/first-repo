Fs=256;
%J=0;
for i=14:24  
    [datao,datah] = edfread(sprintf('chb12_%g.edf',i),'targetSignals',[1:4,6:9,14:17,19:22,11,12]);
    aa=datah(9:10,:);
    datah(9:16,:)=datah(11:18,:);
    datah(17:18,:)=aa;
    temp=datah';
    N=size(temp,1);
    F=size(temp,2);
    G=(N/256);
    M=N*F/256;
    vals=zeros(256,M);
    for k=1:G
        j=1:F;
        vals(:,G*(j-1)+k)=temp(1+256*(k-1):256*(k),j);
    end
    t=1:M;
    Pxx = abs(fftshift(fft(vals(:,t),256))).^2;
    Pxx = 2*Pxx(129:256,:);
    for l=1:M
               %final_data(J+mod(l-1,G)+1,8*(floor((l-1)./G))+1)=sum(Pxx(2:4,l));
               %final_data(J+mod(l-1,G)+1,8*(floor((l-1)./G))+2)=sum(Pxx(5:7,l));
               %final_data(J+mod(l-1,G)+1,8*(floor((l-1)./G))+3)=sum(Pxx(8:10,l));
               %final_data(J+mod(l-1,G)+1,8*(floor((l-1)./G))+4)=sum(Pxx(11:13,l));
               %final_data(J+mod(l-1,G)+1,8*(floor((l-1)./G))+5)=sum(Pxx(14:16,l));
               %final_data(J+mod(l-1,G)+1,8*(floor((l-1)./G))+6)=sum(Pxx(17:19,l));
               %final_data(J+mod(l-1,G)+1,8*(floor((l-1)./G))+7)=sum(Pxx(20:22,l));
               %final_data(J+mod(l-1,G)+1,8*(floor((l-1)./G))+8)=sum(Pxx(23:26,l));
               %final_data(J+mod(l-1,G)+1,(floor((l-1)./G))+1)=entrop(vals(:,l));
               %final_data(J+mod(l-1,G)+1,(floor((l-1)./G))+1)=petropy(vals(:,l),7,1,'order');
               final_data(J+mod(l-1,G)+1,7*(floor((l-1)./G))+1)=entrop(Pxx(:,l));
               final_data(J+mod(l-1,G)+1,7*(floor((l-1)./G))+2)=checkfornan(skewness(vals(:,l)));
               final_data(J+mod(l-1,G)+1,7*(floor((l-1)./G))+3)=checkfornan(kurtosis(vals(:,l)));
               final_data(J+mod(l-1,G)+1,7*(floor((l-1)./G))+4)=var(vals(:,l));
               final_data(J+mod(l-1,G)+1,7*(floor((l-1)./G))+5)=complexity(vals(:,l));
               final_data(J+mod(l-1,G)+1,7*(floor((l-1)./G))+6)=mobility(vals(:,l));
               final_data(J+mod(l-1,G)+1,7*(floor((l-1)./G))+7)=rms(vals(:,l));
    end
    i
    J=size(final_data,1);
end

for p=1:size(final_data,2);
t=1:size(final_data,1);    
final(t,p)=(final_data(t,p)-mean(final_data(:,p)))/(std(final_data(:,p)));
end;