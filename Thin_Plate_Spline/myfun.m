function V = myfun(lambda,D,Z_t,n)
for i=1:size(D,1)
    D_t(i)=n*lambda/(D(i)^2+n*lambda);
end
V=n*sum(D_t.*D_t.*Z_t',2)/(sum(D_t,2))^2;
end