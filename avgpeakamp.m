function apa =avgpeakamp(x)
K=0;
check=0;
N=length(x);
res=0;
for i=2:N-1
    if (x(i)>x(i-1) && x(i)>x(i+1))
        res=res+x(i)^2;
        K=K+1;
    elseif (x(i)>x(i-1) && x(i)==x(i+1))
        res=res+x(i)^2;
        K=K+1;
        check=1;
    elseif (x(i)==x(i-1)==x(i+1))
        res=res+0;
        K=K+0;
    elseif (x(i)==x(i-1) && x(i)>x(i+1) && check==1)
        check=0;
    end
end
if (res>0)
    apa=log10(res/K);
else
    apa=0;
end
end