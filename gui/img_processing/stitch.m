%converts 8 input data matrices to pointcloud objects and then
%returns single merged point cloud
function pcStitched = stitch(I0, I45, I90, I135, I180, I225, I270, I315)
    %create pointCloud objects from input data
    %img 1 data
    xyz = [I0(:, 1), I0(:, 2), I0(:, 3)];
    rgb = [I0(:, 4), I0(:, 5), I0(:, 6)];
    pc0 = pcdenoise(pointCloud(xyz, 'color', rgb));
    
    %img 2 data
    xyz = [I45(:, 1), I45(:, 2), I45(:, 3)];
    rgb = [I45(:, 4), I45(:, 5), I45(:, 6)];
    pc45 =pcdenoise( pointCloud(xyz, 'color', rgb));
    
    %img 3 data
    xyz = [I90(:, 1), I90(:, 2), I90(:, 3)];
    rgb = [I90(:, 4), I90(:, 5), I90(:, 6)];
    pc90 = pcdenoise(pointCloud(xyz, 'color', rgb));
    
    %img 4 data
    xyz = [I135(:, 1), I135(:, 2), I135(:, 3)];
    rgb = [I135(:, 4), I135(:, 5), I135(:, 6)];
    pc135 = pcdenoise(pointCloud(xyz, 'color', rgb));
    
    %img 5 data
    xyz = [I180(:, 1), I180(:, 2), I180(:, 3)];
    rgb = [I180(:, 4), I180(:, 5), I180(:, 6)];
    pc180 = pcdenoise(pointCloud(xyz, 'color', rgb));
    
    %img 6 data
    xyz = [I225(:, 1), I225(:, 2), I225(:, 3)];
    rgb = [I225(:, 4), I225(:, 5), I225(:, 6)];
    pc225 = pcdenoise(pointCloud(xyz, 'color', rgb));
    
    %img 7 data
    xyz = [I270(:, 1), I270(:, 2), I270(:, 3)];
    rgb = [I270(:, 4), I270(:, 5), I270(:, 6)];
    pc270 = pcdenoise(pointCloud(xyz, 'color', rgb));
    
    %img 8 data
    xyz = [I315(:, 1), I315(:, 2), I315(:, 3)];
    rgb = [I315(:, 4), I315(:, 5), I315(:, 6)];
    pc315 = pcdenoise(pointCloud(xyz, 'color', rgb));
    
    %translate all point clouds for easier alignment later
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
    
    %realign point clouds
    pc0_center = mean(pc0.Location);
    pc45_center = mean(pc45.Location);
    pc90_center = mean(pc90.Location);
    pc135_center = mean(pc135.Location);
    pc180_center = mean(pc180.Location);
    pc225_center = mean(pc225.Location);
    pc270_center = mean(pc270.Location);
    pc315_center = mean(pc315.Location);
    total = [pc0_center; 
             pc45_center; 
             pc90_center;
             pc135_center; 
             pc180_center; 
             pc225_center; 
             pc270_center;
             pc315_center];
         
    %translate 45 deg point cloud
    x = total(1,1) - total(2,1);
    z = total(1,3) - total(2,3);
    pcInput = pc45;
    pcStitched = pc0;
    pcStitched = pcMinMerge(x, z, pcInput, pcStitched);

    %translate 90 deg point cloud
    x = total(1,1) - total(3,1);
    z = total(1,3) - total(3,3);
    pcInput = pc90;
    pcStitched = pcMinMerge(x, z, pcInput, pcStitched);

    %translate 135 deg point cloud
    x = total(1,1) - total(4,1);
    z = total(1,3) - total(4,3);
    pcInput = pc135;
    pcStitched = pcMinMerge(x, z, pcInput, pcStitched);

    %translate 180 deg point cloud
    x = total(1,1) - total(5,1);
    z = total(1,3) - total(5,3);
    pcInput = pc180;
    pcStitched = pcMinMerge(x, z, pcInput, pcStitched);
    
    %translate 225 deg point cloud
    x = total(1,1) - total(6,1);
    z = total(1,3) - total(6,3);
    pcInput = pc225;
    pcStitched = pcMinMerge(x, z, pcInput, pcStitched);

    %translate 270 deg point cloud
    x = total(1,1) - total(7,1);
    z = total(1,3) - total(7,3);
    pcInput = pc270;
    pcStitched = pcMinMerge(x, z, pcInput, pcStitched);
    
    %translate 315 deg point cloud
    x = total(1,1) - total(8,1);
    z = total(1,3) - total(8,3);
    pcInput = pc315;
    pcStitched = pcMinMerge(x, z, pcInput, pcStitched);
    
    %remove noise from merged cloud
    for i = 1 : 5
        pcStitched = pcdenoise(pcStitched);
    end
end