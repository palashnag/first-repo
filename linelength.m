function ll=linelength(x)
N=length(x);
ll=0;
for i=2:N
    ll=ll+abs(x(i)-x(i-1));
end
end