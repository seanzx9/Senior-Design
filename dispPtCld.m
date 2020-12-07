%display point cloud data in 3D plot
function dispPtCld(data, t)   
    x = data(:, 1);
    y = data(:, 2);
    z = data(:, 3);
    
    r = data(:, 4);
    g = data(:, 5);
    b = data(:, 6);
    
    scatter3(x, z, -y, [], [r, g, b] / 255, '.');
    grid on;
    title(t);
    xlabel('X');
    ylabel('Z');
    zlabel('Y');
end