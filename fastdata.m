Fs=256;
J=0;
for i=14:24
    [datao,datah] = edfread(sprintf('chb12_%g.edf',i),'targetSignals',[1:4,6:9,14:17,19:22,11,12]);
    aa=datah(9:10,:);
    datah(9:16,:)=datah(11:18,:);
    datah(17:18,:)=aa;
    temp=datah';
    N=size(temp,1);
    if (mod(N/256,2)>0)
        temp=temp(1:(N-256),:);
    end
    N=size(temp,1);
    G=(N/512);
    M=N*18/512;
    vals=zeros(512,M);
    for k=1:G
        j=1:18;
        vals(:,G*(j-1)+k)=temp(1+512*(k-1):512*(k),j);
    end
    t=1:M;
    Pxx = abs(fftshift(fft(vals(:,t),512))).^2;
    Pxx = 2*Pxx(257:512,:);
    %f = Fs/2*linspace(0,1,257);
    for l=1:M
               final_data(J+mod(l-1,G)+1,8*(floor((l-1)./G))+1)=sum(Pxx(2:7,l));
               final_data(J+mod(l-1,G)+1,8*(floor((l-1)./G))+2)=sum(Pxx(8:13,l));
               final_data(J+mod(l-1,G)+1,8*(floor((l-1)./G))+3)=sum(Pxx(14:19,l));
               final_data(J+mod(l-1,G)+1,8*(floor((l-1)./G))+4)=sum(Pxx(20:25,l));
               final_data(J+mod(l-1,G)+1,8*(floor((l-1)./G))+5)=sum(Pxx(26:31,l));
               final_data(J+mod(l-1,G)+1,8*(floor((l-1)./G))+6)=sum(Pxx(32:37,l));
               final_data(J+mod(l-1,G)+1,8*(floor((l-1)./G))+7)=sum(Pxx(38:43,l));
               final_data(J+mod(l-1,G)+1,8*(floor((l-1)./G))+8)=sum(Pxx(44:50,l));
    end
    i
    J=size(final_data,1);
end

for p=1:144;
t=1:size(final_data,1);    
final_data(t,p)=(final_data(t,p)-min(final_data(:,p)))/(max(final_data(:,p))-min(final_data(:,p)));
end;