function B = SensingMatrix(m,n,gb)
if gb==1
    idx = randperm(m*n);
    idx = idx(1:m*n/2);
    B = ones(m,n);
    B(idx) = -1;
elseif gb==2
    B = normrnd(0,1,m,n);
elseif gb==3
    idx=randperm(s(1)*s(2));
    idx=idx(1:ceil(m*s(1)*s(2)/100));
    B=opMyRestriction(s(1)*s(2),idx);
end

end