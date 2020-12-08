%converts 8 input data matrices to pointcloud objects and then
%returns single merged point cloud
function pcMerged = stitch(I0, I45, I90, I135, I180, I225, I270, I315)
    %find largest point cloud for reference point cloud
    [n1, ~] = size(I0);
    [n2, ~] = size(I45);
    [n3, ~] = size(I90);
    [n4, ~] = size(I135);
    [n5, ~] = size(I180);
    [n6, ~] = size(I225);
    [n7, ~] = size(I270);
    [n8, ~] = size(I315);
    [~, refInd] = max([n1, n2, n3, n4, n5, n6, n7, n8]);

    %create pointCloud objects from input data
    %img 1 data
    xyz = [I0(:, 1), I0(:, 2), I0(:, 3)];
    rgb = [I0(:, 4), I0(:, 5), I0(:, 6)];
    pc0 = pointCloud(xyz, 'color', rgb);
    
    %img 2 data
    xyz = [I45(:, 1), I45(:, 2), I45(:, 3)];
    rgb = [I45(:, 4), I45(:, 5), I45(:, 6)];
    pc45 = pointCloud(xyz, 'color', rgb);
    
    %img 3 data
    xyz = [I90(:, 1), I90(:, 2), I90(:, 3)];
    rgb = [I90(:, 4), I90(:, 5), I90(:, 6)];
    pc90 = pointCloud(xyz, 'color', rgb);
    
    %img 4 data
    xyz = [I135(:, 1), I135(:, 2), I135(:, 3)];
    rgb = [I135(:, 4), I135(:, 5), I135(:, 6)];
    pc135 = pointCloud(xyz, 'color', rgb);
    
    %img 5 data
    xyz = [I180(:, 1), I180(:, 2), I180(:, 3)];
    rgb = [I180(:, 4), I180(:, 5), I180(:, 6)];
    pc180 = pointCloud(xyz, 'color', rgb);
    
    %img 6 data
    xyz = [I225(:, 1), I225(:, 2), I225(:, 3)];
    rgb = [I225(:, 4), I225(:, 5), I225(:, 6)];
    pc225 = pointCloud(xyz, 'color', rgb);
    
    %img 7 data
    xyz = [I270(:, 1), I270(:, 2), I270(:, 3)];
    rgb = [I270(:, 4), I270(:, 5), I270(:, 6)];
    pc270 = pointCloud(xyz, 'color', rgb);
    
    %img 8 data
    xyz = [I315(:, 1), I315(:, 2), I315(:, 3)];
    rgb = [I315(:, 4), I315(:, 5), I315(:, 6)];
    pc315 = pointCloud(xyz, 'color', rgb);
    
    %translate all point clouds for alignment
    x = 0.15;
    z = -0.3;
    A = [1, 0, 0, 0;
         0, 1, 0, 0;
         0, 0, 1, 0;
         x, 0, z, 1];
    tform = affine3d(A);
    pc0 = pctransform(pc0, tform);
    pc45 = pctransform(pc45, tform);
    pc90 = pctransform(pc90, tform);
    pc135 = pctransform(pc135, tform);
    pc180 = pctransform(pc180, tform);
    pc225 = pctransform(pc225, tform);
    pc270 = pctransform(pc270, tform);
    pc315 = pctransform(pc315, tform);    
    
    %rotate all point clouds on y axis
    %rotate -45 deg
    a = -(pi / 4);
    A = [cos(a), 0, -sin(a), 0;
         0, 1, 0, 0;
         sin(a), 0, cos(a), 0;
         0, 0, 0, 1];
    tform = affine3d(A);
    pc45 = pctransform(pc45, tform);
    
    %rotate -90 deg
    a = -(pi / 2);
    A = [cos(a), 0, -sin(a), 0;
         0, 1, 0, 0;
         sin(a), 0, cos(a), 0;
         0, 0, 0, 1];
    tform = affine3d(A);
    pc90 = pctransform(pc90, tform);
    
    %rotate 135 deg
    a = -(3*pi/4);
    A = [cos(a), 0, -sin(a), 0;
         0, 1, 0, 0;
         sin(a), 0, cos(a), 0;
         0, 0, 0, 1];
    tform = affine3d(A);
    pc135 = pctransform(pc135, tform);
    
    %rotate 180 deg
    a = pi;
    A = [cos(a), 0, -sin(a), 0;
         0, 1, 0, 0;
         sin(a), 0, cos(a), 0;
         0, 0, 0, 1];
    tform = affine3d(A);
    pc180 = pctransform(pc180, tform);
    
    %rotate -225 deg
    a = -(5 * pi / 4);
    A = [cos(a), 0, -sin(a), 0;
         0, 1, 0, 0;
         sin(a), 0, cos(a), 0;
         0, 0, 0, 1];
    tform = affine3d(A);
    pc225 = pctransform(pc225, tform);
    
    %rotate -270 deg
    a = -(3 * pi / 2);
    A = [cos(a), 0, -sin(a), 0;
         0, 1, 0, 0;
         sin(a), 0, cos(a), 0;
         0, 0, 0, 1];
    tform = affine3d(A);
    pc270 = pctransform(pc270, tform);
    
    %rotate -315 deg
    a = -(7 * pi / 4);
    A = [cos(a), 0, -sin(a), 0;
         0, 1, 0, 0;
         sin(a), 0, cos(a), 0;
         0, 0, 0, 1];
    tform = affine3d(A);
    pc315 = pctransform(pc315, tform);
        
    %add all clouds to list
    pc = [pc0, pc45, pc90, pc135, pc180, pc225, pc270, pc315];
    
    %merge clouds
    mergeSize = 0.01;
    pcRef = pc(refInd);
    for i = 1 : 8
        if i ~= refInd
           pcMerged = pcmerge(pcRef, pc(i), mergeSize); 
        end
    end
     
    %individual point clouds
    figure;
    subplot(2, 4, 1), dispPtCld(pc(1), '0 degrees');
    subplot(2, 4, 2), dispPtCld(pc(2), '45 degrees');
    subplot(2, 4, 3), dispPtCld(pc(3), '90 degrees');
    subplot(2, 4, 4), dispPtCld(pc(4), '135 degrees');
    subplot(2, 4, 5), dispPtCld(pc(5), '180 degrees');
    subplot(2, 4, 6), dispPtCld(pc(6), '225 degrees');
    subplot(2, 4, 7), dispPtCld(pc(7), '270 degrees');
    subplot(2, 4, 8), dispPtCld(pc(8), '315 degrees');
    
    %merged point cloud
    figure;
    dispPtCld(pcMerged, 'Merged Point Cloud')
end