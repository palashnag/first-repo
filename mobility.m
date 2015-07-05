function [mobility] = mobility(xV)
dxV = diff([0;xV]);
mx2 = var(xV);
mdx2 = var(dxV);
mob = mdx2 / mx2;
mobility = sqrt(mob);  
if (isnan(mobility)==1)
    mobility=0;
end
end