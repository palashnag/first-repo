function pv = peakvar(x)
N=length(x);
check=0;
checke=0;
P=[];
xp=[];
V=[];
xv=[];
for i=2:N-1
    if (x(i)>x(i-1) && x(i)>x(i+1))
        P=[P;i];
        xp=[xp;x(i)];
    elseif (x(i)>x(i-1) && x(i)==x(i+1))
        checkeak=i;
        checkeakval=x(i);
        check=1;
    elseif (x(i)==x(i-1)==x(i+1))
        ;
    elseif (x(i)==x(i-1) && x(i)>x(i+1) && check==1)
        check=0;
        P=[P;(checkeak+i)/2];
        xp=[xp;(x(i)+checkeakval)/2];
    elseif (i==(N-1) && check==1)
        check=0;
        P=[P;checkeak];
        xp=[xp;checkeakval];
        
    elseif (x(i)<x(i-1) && x(i)<x(i+1))
        V=[V;i];
        xv=[xv;x(i)];
    elseif (x(i)<x(i-1) && x(i)==x(i+1))
        temval=i;
        temvalval=x(i);
        checke=1;
    elseif (x(i)==x(i-1) && x(i)<x(i+1) && checke==1)
        checke=0;
        V=[V;(temval+i)/2];
        xv=[xv;(x(i)+temvalval)/2];
    elseif (i==(N-1) && checke==1)
        checke=0;
        V=[V;temval];
        xv=[xv;temvalval];
    end
end
a=min(size(P,1),size(V,1));
if (a==0)
    pv=0.01;
else
P=P(1:a);
V=V(1:a);
xp=xp(1:a);
xv=xv(1:a);
dpv=mean(P-V);
dx=mean(xp-xv);
sigpv=sqrt(sum((P-V-dpv).^2)/(length(P-V)-1));
sigx=sqrt(sum((xp-xv-dx).^2)/(length(xp-xv)-1));
pv=1/(sigpv*sigx);
if (isnan(pv)==1)
    pv=0.01;
   
elseif (pv==Inf)
    pv=0.01;
   
end
end
end