function npn =normpeaknum(x)
K=0;
check=0;
N=length(x);
for i=2:N-1
    if (x(i)>x(i-1) && x(i)>x(i+1))
        K=K+1;
    elseif (x(i)>x(i-1) && x(i)==x(i+1))
        K=K+1;
        check=1;
    elseif (x(i)==x(i-1)==x(i+1))
        K=K+0;
    elseif (x(i)==x(i-1) && x(i)>x(i+1) && check==1)
        check=0;
    end
end
if (linelength(x)>0)
npn=K/(linelength(x)/(N-1));
else
npn=0;
end
end