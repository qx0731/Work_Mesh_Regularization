function [affine non_affine]=tps_compute_params(Q1,Q2,R,Y1,K,lambda,varargin)
% Y is the tagent points n*2 or n*3
% param=[affine:non_affine]
% input a column vector as a weight vector for those points
% iws is the inverse W square(take as the covariance matrix )
Y=tps_n_c(Y1);
n=size(K,1);
if isempty(varargin)
    iws=diag(ones(n,1));
else
    if length(varargin)==1
    iws=varargin{1};
    else
        error('only accept one more paramaters');
    end
end
if size(iws)~=[n,n]
    error('weight vector need to be same length as the # of points');
    
end
M=K+n*lambda*iws;
non_affine=(Q2/(Q2'*M*Q2))*Q2'*Y;
affine=(R\Q1')*(Y-M*non_affine);
