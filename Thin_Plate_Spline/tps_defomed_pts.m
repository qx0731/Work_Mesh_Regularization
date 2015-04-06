function [new_pt K]=tps_defomed_pts(pt,affine,non_affine,ctrl_pts)
[m1,d]=size(ctrl_pts);
%K=pdist2(pt,ctrl_pts,'euclidean');
Yt = ctrl_pts';
XX = sum(pt.*pt,2);
YY = sum(Yt.*Yt,1);
K = bsxfun(@plus,XX,YY)-2*pt*Yt;
K=K.*(K>=0);
%K=sqrt(K.*(K>=0));
% K=K.^2;
if d==1
    K=sqrt(K).^3;
else
    if d==2
        mask = K < 1e-10; % to avoid singularity.
        K = 0.5 * K .* log(K + mask) .* (K>1e-10);
    else
        K = - sqrt(K);
    end;
end
pt=tps_n_c(pt);
new_pt=pt*affine+K*non_affine;



% function new_pt=tps_defomed_pts(pt,affine,non_affine,ctrl_pts)
% [m1,d]=size(ctrl_pts);
% A=repmat(pt,m1,1)-ctrl_pts;
% K1=sum(A.^2,2);
% if d==1
%     K=sqrt(K).^3;
% else
%     if d==2
%         mask = K < 1e-10; % to avoid singularity.
%         K = 0.5 * K .* log(K + mask) .* (K>1e-10);
%     else
%         K = - sqrt(K);
%     end;
% end
% pt=tps_n_c(pt);
% new_pt=pt*affine+K'*non_affine;
