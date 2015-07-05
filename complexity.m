function [complexity] = complexity(xV)
dxV = diff([0;xV]);
ddxV = diff([0;dxV]);
mx2 = var(xV);
mdx2 = var(dxV);
mddx2 = var(ddxV);
complexity = sqrt(mddx2*mx2)/mdx2;  
if (isnan(complexity)==1)
    complexity=0;
end
end