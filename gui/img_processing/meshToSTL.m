%converts mesh to STL file
function meshToSTL(mesh)
    %get facets that make up the boundary of the alpha shape
    [bf, P] = boundaryFacets(mesh);
    
    %write to STL file
    stlwrite(triangulation(bf, P), 'stlData/res.stl');
end