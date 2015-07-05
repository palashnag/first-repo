function entr= entrop(x)
entr=0;
for i=1:length(x)
    if (x(i)==0)
        entr=entr+0;
    else
        entr=entr+x(i)*log10(x(i)^2);
    end
end

