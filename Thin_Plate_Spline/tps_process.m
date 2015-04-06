function tps_result=tps_process(ctrl_pts,Y1,test_pts,lambda)
[K] = tps_compute_dist_matrix(ctrl_pts);
[Pm,Q1,Q2,R] = tps_set_matrices(ctrl_pts);
if(~exist('lambda','var'))
    lambda=gcv_lambda(ctrl_pts,Y1,Q2,K);
end
if lambda>1;
    lambda=1e-6;
end

[affine non_affine] = tps_compute_params(Q1,Q2,R,Y1,K,lambda);

new_pt=tps_defomed_pts(test_pts,affine,non_affine,ctrl_pts);
tps_result=new_pt(:,[2:end]);