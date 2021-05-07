%get data from realsense depth camera
%returns 921600x6 matrix=>[x, y, z, r, g, b]
function data = captureData()
    %make pipeline object to manage streaming
    pointcloud = realsense.pointcloud();  
    pipe = realsense.pipeline();

    %start streaming on an arbitrary camera with default settings
    pipe.start();
    align_to = realsense.stream.color;
    alignedFs = realsense.align(align_to);

    %get frames w/o the first couple to allow the camera time to settle
    for i = 1 : 5
        fs = pipe.wait_for_frames();

        %align the depth frames to the color stream
        aligned_frames = alignedFs.process(fs);
        depth = aligned_frames.get_depth_frame();

        %adjust frame CS to matlab CS
        points = pointcloud.calculate(depth);
        vertices = points.get_vertices();
        x = vertices(:, 1);
        y = vertices(:, 2);
        z = vertices(:, 3);
        pointCloud = [x, y, z];

        %select rgb frame
        color = fs.get_color_frame();
        colordata = color.get_data();
        
        %match colors to point cloud
        rgbPoints = double(reshape(colordata', [3, length(pointCloud)])');
        data = [pointCloud, rgbPoints];
    end
    
    %stop streaming
    pipe.stop();
end