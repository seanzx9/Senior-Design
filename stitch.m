function f = stitch(I1, I2, I3, I4, I5, I6, I7, I8)
    %create pointCloud object from img 1 data
    xyz1 = [I1(:, 1), I1(:, 2), I1(:, 3)];
    rgb1 = [I1(:, 4), I1(:, 5), I1(:, 6)];
    pc1 = pointCloud(xyz1, 'color', rgb1);
    
    %create pointCloud object from img 2 data
    xyz2 = [I2(:, 1), I2(:, 2), I2(:, 3)];
    rgb2 = [I2(:, 4), I2(:, 5), I2(:, 6)];
    pc2 = pointCloud(xyz2, 'color', rgb2);
    
    %create pointCloud object from img 3 data
    xyz3 = [I3(:, 1), I3(:, 2), I3(:, 3)];
    rgb3 = [I3(:, 4), I3(:, 5), I3(:, 6)];
    pc3 = pointCloud(xyz3, 'color', rgb3);
    
    %create pointCloud object from img 4 data
    xyz4 = [I4(:, 1), I4(:, 2), I4(:, 3)];
    rgb4 = [I4(:, 4), I4(:, 5), I4(:, 6)];
    pc4 = pointCloud(xyz4, 'color', rgb4);
    
    %create pointCloud object from img 5 data
    xyz5 = [I5(:, 1), I5(:, 2), I5(:, 3)];
    rgb5 = [I5(:, 4), I5(:, 5), I5(:, 6)];
    pc5 = pointCloud(xyz5, 'color', rgb5);
    
    %create pointCloud object from img 6 data
    xyz6 = [I6(:, 1), I6(:, 2), I6(:, 3)];
    rgb6 = [I6(:, 4), I6(:, 5), I6(:, 6)];
    pc6 = pointCloud(xyz6, 'color', rgb6);
    
    %create pointCloud object from img 7 data
    xyz7 = [I7(:, 1), I7(:, 2), I7(:, 3)];
    rgb7 = [I7(:, 4), I7(:, 5), I7(:, 6)];
    pc7 = pointCloud(xyz7, 'color', rgb7);
    
    %create pointCloud object from img 8 data
    xyz8 = [I8(:, 1), I8(:, 2), I8(:, 3)];
    rgb8 = [I8(:, 4), I8(:, 5), I8(:, 6)];
    pc8 = pointCloud(xyz8, 'color', rgb8);
    
    %downsample to improve accuracy and speed
%     gridSize = 0.1;
%     fixed = pcdownsample(pc1, 'gridAverage', gridSize);
%     moving = pcdownsample(pc2, 'gridAverage', gridSize);
%     
%     %register data
%     tform = pcregistericp(moving, fixed, 'Metric', 'pointToPlane', 'Extrapolate', true);
%     ptCloudAligned = pctransform(pc1, tform);
%     
%     mergeSize = 0.015;
%     ptCloudScene = pcmerge(pc1, ptCloudAligned, mergeSize);

    figure
    subplot(2, 2, 1), pcshow(pc1);
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    drawnow;

    subplot(2, 2, 3), pcshow(pc2);
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    drawnow;

    subplot(2, 2, [2,4]), pcshow(ptCloudScene)
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    drawnow;
      
    f = I1;
end