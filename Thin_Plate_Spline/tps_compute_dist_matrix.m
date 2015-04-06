function [K] = tps_compute_dist_matrix(x)
% compute the kernel function based on the control points

% Input X in N*k (k is the dimension)
% Output
% K is the kernel matrix
% 1D :K = r^3
% 2D: K = r^2 * log r
% 3D: K = -r
% ave is the mean distance between cotrol points
[n, d] = size (x);
K = zeros (n,n);

for i=1:d
    tmp = x(:,i) * ones(1,n) - ones(n,1) * x(:,i)';
    tmp = tmp .* tmp;
    K = K + tmp;
end;

if d==1
    K=sqrt(K).^3;
else
    if d == 2
        mask = K < 1e-10; % to avoid singularity.
        K = 0.5 * K .* log(K + mask) .* (K>1e-10);
    else
        K = - sqrt(K);
    end;
end




