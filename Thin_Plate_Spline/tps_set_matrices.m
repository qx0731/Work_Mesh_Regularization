function [Pm,Q1,Q2,R] = tps_set_matrices(ctrl_pts)
[m,d] = size(ctrl_pts);
Pm = [ones(m,1) ctrl_pts];
[q,r]   = qr(Pm);
Q1      = q(:, 1:d+1);
Q2      = q(:, d+2:m);
R       = r(1:d+1,1:d+1);

