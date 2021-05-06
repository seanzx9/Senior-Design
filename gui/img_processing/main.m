%main driver function
%1 to capture new data, otherwise use old data
%1 to display data, otherwise don't show
function main(capture, display)
    if capture == 1
        %get LIVE capture from camera 
        I0 = captureData(); 
        save('imgData/I0.mat', 'I0');
        disp('0 degrees saved...');
        pause;
        I45 = captureData(); 
        save('imgData/I45.mat', 'I45');
        disp('45 degrees saved...');
        pause;
        I90 = captureData(); 
        save('imgData/I90.mat', 'I90');
        disp('90 degrees saved...');
        pause;
        I135 = captureData(); 
        save('imgData/I135.mat', 'I135');
        disp('135 degrees saved...');
        pause;
        I180 = captureData(); 
        save('imgData/I180.mat', 'I180');
        disp('180 degrees saved...');
        pause;
        I225 = captureData(); 
        save('imgData/I225.mat', 'I225');
        disp('225 degrees saved...');
        pause;
        I270 = captureData(); 
        save('imgData/I270.mat', 'I270');
        disp('270 degrees saved...');
        pause;
        I315 = captureData(); 
        save('imgData/I315.mat', 'I315');
        disp('315 degrees saved...');
    else
        %get SAVED capture data from camera
        I0 = load('imgData/I0.mat').I0;
        I45 = load('imgData/I45.mat').I45;
        I90 = load('imgData/I90.mat').I90;
        I135 = load('imgData/I135.mat').I135;
        I180 = load('imgData/I180.mat').I180;
        I225 = load('imgData/I225.mat').I225;
        I270 = load('imgData/I270.mat').I270;
        I315 = load('imgData/I315.mat').I315;
    end

    %raw capture data
    if display == 1
        figure;
        subplot(2, 4, 1), dispPtCld(I0, '0 degrees');
        subplot(2, 4, 2), dispPtCld(I45, '45 degrees');
        subplot(2, 4, 3), dispPtCld(I90, '90 degrees');
        subplot(2, 4, 4), dispPtCld(I135, '135 degrees');
        subplot(2, 4, 5), dispPtCld(I180, '180 degrees');
        subplot(2, 4, 6), dispPtCld(I225, '225 degrees');
        subplot(2, 4, 7), dispPtCld(I270, '270 degrees');
        subplot(2, 4, 8), dispPtCld(I315, '315 degrees');
    end

    %process capture data 
    I0 = process(I0);
    save('ptCldData/I0.mat', 'I0');
    I45 = process(I45);
    save('ptCldData/I45.mat', 'I45');
    I90 = process(I90);
    save('ptCldData/I90.mat', 'I90');
    I135 = process(I135);
    save('ptCldData/I135.mat', 'I135');
    I180 = process(I180);
    save('ptCldData/I180.mat', 'I180');
    I225 = process(I225);
    save('ptCldData/I225.mat', 'I225');
    I270 = process(I270);
    save('ptCldData/I270.mat', 'I270');
    I315 = process(I315);
    save('ptCldData/I315.mat', 'I315');

    %processed capture data
    if display == 1
        figure;
        subplot(2, 4, 1), dispPtCld(I0, '0 degrees');
        subplot(2, 4, 2), dispPtCld(I45, '45 degrees');
        subplot(2, 4, 3), dispPtCld(I90, '90 degrees');
        subplot(2, 4, 4), dispPtCld(I135, '135 degrees');
        subplot(2, 4, 5), dispPtCld(I180, '180 degrees');
        subplot(2, 4, 6), dispPtCld(I225, '225 degrees');
        subplot(2, 4, 7), dispPtCld(I270, '270 degrees');
        subplot(2, 4, 8), dispPtCld(I315, '315 degrees');
    end

    %3D stitch all point clouds to one
    ptCld = stitch(I0, I45, I90, I135, I180, I225, I270, I315);

    %display full point cloud
    if display == 1
        figure;
        dispPtCld(ptCld, 'Fully Merged Point Cloud');
    end

    %convert point cloud to mesh
    mesh = ptCldToMesh(ptCld);

    %display mesh 
    if display == 1
        figure;
        title('Mesh');
        plot(mesh);
    end

    %saves mesh as stl file
    meshToSTL(mesh);
end