function Y=tps_n_c(Y1)
%input Y1 is the points in n*k dimension
%output Y is the concatennated version of Y1
[m n]=size(Y1);
Y=[ones(m,1) Y1];
