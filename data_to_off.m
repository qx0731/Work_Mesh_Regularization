% Write off file from Tri and Pts
function data_to_off(Tri,Pts,out)
%output: with output the off file
% input Tri is the trianglule information of the shape, the min of the
% index begin at 1
% Pts gives the coordinates of the points
% tri and Pts are both in form k*n such as 3*n
% out is the name of the output off file

% Example
% [Tri,Pts] = ply_read('sphere_642.ply','tri');
% data_to_off(Tri,Pts,'test.off')
if max(max(Tri))>size(Pts,2)
    error('bad input');
else
    ptsnum=size(Pts,2);
    % insert the first row of the Pts into 3
    trinum=size(Tri,2);
    Tri=Tri-1;
    b=3*ones(1,trinum);
    Tri=[b;Tri];
    c=[ptsnum;trinum;0];
    %preparation work
    
    
    fid = fopen(out,'w');
    head='OFF';
    fprintf(fid,'%s\n',head);  
    fprintf(fid,'%u %u %u\n',c);
    fprintf(fid,'%f %f %f\n',Pts);
    fprintf(fid, '%u %u %u %u\n', Tri);
    fclose(fid);
    %write data into file
    %details about u s \n \t by looking at the fprintf
    %\t tab delimited
end
