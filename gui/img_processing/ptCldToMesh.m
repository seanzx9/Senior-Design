%converts a point cloud object into a mesh object
function mesh = ptCldToMesh(ptCld) 
    %x, y, and z coordinates of point cloud
    x = ptCld.Location(:, 1);
    y = ptCld.Location(:, 2);
    z = ptCld.Location(:, 3);
    
    %create alpha mesh  
    mesh = alphaShape(x, y, z);
    
    %find and set critical alpha
    alpha = criticalAlpha(mesh, 'one-region');
    mesh.Alpha = alpha;
end