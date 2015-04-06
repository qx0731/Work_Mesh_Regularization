function [lambda D]=gcv_lambda(ctrl_pts,Y,Q2,K)
% in my implement, I used n*lambda. So find the minimal lambda then
% multiply by n at the end
%[Pm,Q1,Q2,R] = tps_set_matrices(ctrl_pts);
%[K] = tps_compute_dist_matrix(ctrl_pts);
n=size(ctrl_pts,1);
L=chol(Q2'*K*Q2);
[U D S]=svd(L');
Y1=tps_n_c(Y);
Z=U'*Q2'*Y1;
Z_t=sum(Z.*Z,2);
D=diag(D);
% lambda=0.0000001;
% j=1;
% for i=1:size(D,1)
%     D_t(i)=n*lambda/(D(i)^2+n*lambda);
% end
% V(j)=n*sum(D_t.*D_t.*Z_t',2)/(sum(D_t,2))^2;
% j=j+1;
% 
% 
% lambda=2*lambda;
% for i=1:size(D,1)
%     D_t(i)=n*lambda/(D(i)^2+n*lambda);
% end
% V(j)=n*sum(D_t.*D_t.*Z_t',2)/(sum(D_t,2))^2;
% 
% while V(j)<=V(j-1)
%     j=j+1;
%     lambda=2*lambda;
%     for i=1:size(D,1)
%         D_t(i)=n*lambda/(D(i)^2+n*lambda);
%     end
%     V(j)=n*sum(D_t.*D_t.*Z_t',2)/(sum(D_t,2))^2;
%     
% end
[lambda temp1 temp2]=fminsearch(@(lambda) myfun(lambda,D,Z_t,n),0);
end

function V = myfun(lambda,D,Z_t,n)
for i=1:size(D,1)
    D_t(i)=n*lambda/(D(i)^2+n*lambda);
end
V=n*sum(D_t.*D_t.*Z_t',2)/(sum(D_t,2))^2;
end






