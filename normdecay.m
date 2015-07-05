function nd=normdecay(x)
N=length(x);
nd=0;
for i=1:N-1
  if (x(i)>x(i+1))
      nd=nd+1;
  end
end
nd=abs((nd/(N-1))-0.5);
end