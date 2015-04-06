function mesh_regularization

%Try Tps on the FEZ
close all
addpath(genpath('Thin_Plate_Spline'));


%% set up parameters
ctrl_size=900; % how many guide points used
extra=2;
l1=60; % discrte for the domain
l2=45;
eps=1e-6;% make sure the boundary point is not too close to the inner point          % in order to avoid the small area trangle
k=1;
%read in the data from the ply files

filename1=input('give the name of original off file\n');
filename2=[filename1, '_spline.off'];
filename1=[filename1, '.off'];
[Pts, Tri]=read_off(filename1);
Pts1=Pts';
ctrl_size=min(ctrl_size, size(Pts,2));

%% Estimate the domain
% Step1: Do PCA on the Pts
[pc,score,eig1] = princomp(Pts');
center=mean(Pts,2)';
hgrid=min(score(:,1))-extra*(max(score(:,1))-min(score(:,1)))/l1:(max(score(:,1))-min(score(:,1)))/l1:max(score(:,1))+extra*(max(score(:,1))-min(score(:,1)))/l1;
vgrid=min(score(:,2))-extra*(max(score(:,2))-min(score(:,2)))/l2:(max(score(:,2))-min(score(:,2)))/l2:max(score(:,2))+extra*(max(score(:,2))-min(score(:,2)))/l2;
f = ksdensity2d([score(:,1),score(:,2)],hgrid,vgrid,[1.06*std(score(:,1))*numel(score(:,1))^(-0.2),1.06*std(score(:,2))*numel(score(:,2))^(-0.2)]);
[ysample,xsample]=meshgrid(vgrid,hgrid);

xsample1=xsample;
ysample1=ysample;
f1=f;
figure;
surf(xsample1,ysample1,-0.3*ones(size(xsample1)),'FaceColor','none','linewidth',1)
hold on
plot3(score(:,1),score(:,2),-score(:,3),'o','MarkerSize',2,...
    'MarkerEdgeColor','none',...
    'MarkerFaceColor',[1,0,0]);
hold on
plot3(score(:,1),score(:,2),-0.3*ones(size(score(:,1))),'o','MarkerSize',2,...
    'MarkerEdgeColor','none','MarkerFaceColor',[.95 .95 .95]),
axis equal;
axis off;
view(0,54)
xLimits = get(gca,'XLim'); %# Get the range of the x axis
yLimits = get(gca,'YLim'); %# Get the range of the y axis
zLimits = get(gca,'ZLim'); %# Get the range of the z axis
lighting phong
camlight infinite


xsample=reshape(xsample, size(xsample,1)*size(xsample,2),1);
ysample=reshape(ysample, size(ysample,1)*size(ysample,2),1);
f=reshape(f, size(f,1)*size(f,2),1);
figure;
scatter(xsample,ysample,15,f,'filled')
hold on
[C_temp h_temp]=contour(xsample1,ysample1,f1);
set(h_temp,'ShowText','on','TextStep',get(h_temp,'LevelStep'))
view(0,90)
axis equal
axis off
colorbar
colormap jet

% Step2:
levelvalue=input('please give a resonable value to find the edge (choose number for green/yellow)\n ');
figure;
edge_temp=contour(xsample1,ysample1,f1,[levelvalue-eps,levelvalue-eps]);
edge=edge_temp(:,2:1+edge_temp(2,1));
N=size(edge,2);

[sample_label]=find(f>levelvalue);
sample=[edge';[xsample(sample_label,:),ysample(sample_label,:)]];

% discrete the domain
clear Pts;
X1=score(:,1);
X2=score(:,2);
Pts=[X1,X2];
indexing=randperm(size(Pts,1));
ctrl=Pts(indexing(1:ctrl_size),:);
y=score(indexing(1:ctrl_size),3);

D = [(1:N-1)' (2:N)';  N 1];
Tri_sample= DelaunayTri(sample(:,1),sample(:,2),D);
IO = inOutStatus(Tri_sample);
clear Pts;
Pts=[ctrl;Tri_sample.X];

figure;
trisurf(Tri_sample.Triangulation(IO,:),Tri_sample.X(:,1),Tri_sample.X(:,2),zeros(size(Tri_sample.X(:,2))),'linewidth',2,'FaceColor','none');
hold on
scatter(xsample,ysample,50,f,'filled')
hold on
plot(edge(1,:),edge(2,:),'k-','linewidth',4)
hold on
axis equal
axis off
view(0,90)
colormap jet



%% Step3: Interpolate the domain to surface
% normal TPS
y_test1=tps_process(ctrl,y,Pts);
err1=norm(y_test1(1:ctrl_size)-y,'fro')./sqrt(ctrl_size);
%fprintf('average error from normal Tps is %g \n',err1);
final_data=[Tri_sample.X(:,1),Tri_sample.X(:,2),y_test1(ctrl_size+1:end)]/pc+repmat(center,numel(y_test1(ctrl_size+1:end)),1);



% Step4: compare the original mesh and interpolated mesh
figure;
subplot(1,2,1)
plot3(Pts1(:,1),Pts1(:,2),Pts1(:,3),'o','MarkerSize',2,...
    'MarkerEdgeColor','none',...
    'MarkerFaceColor',[1,0,0]);
axis equal;
axis off;
view(-90,90)
xLimits = get(gca,'XLim'); %# Get the range of the x axis
yLimits = get(gca,'YLim'); %# Get the range of the y axis
zLimits = get(gca,'ZLim'); %# Get the range of the z axis
lighting phong
camlight infinite
title('Original Mesh')


subplot(1,2,2)
trisurf(Tri_sample.Triangulation(IO,:),final_data(:,1),final_data(:,2),final_data(:,3),'EdgeColor','none','FaceColor',[255,99,71]./255);
axis equal;
axis off;
xlim(xLimits)
ylim(yLimits)
zlim(zLimits)
view(-90,90)
lighting phong
camlight infinite
title('Interpolated Mesh')




% save the interpolated into off file
data_to_off(Tri_sample.Triangulation(IO,:)',[final_data]',filename2)