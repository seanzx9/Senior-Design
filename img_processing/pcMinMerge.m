%finds the optimal point cloud translation in 10cm range to use for a merge 
%x = how far in the X-axis the PC is away from the merged PC
%y = how far in the Y-axis the PC is away from the merged PC
%pcInput = the PC that needs to be moved to the correct place
%pcRef = the reference PC that will merge with pcInput
function pcMerged = pcMinMerge(xDist, zDist, pcInput, pcRef)
    %given mergeSize
    mergeSize = 0.001;

    %find optimal x axis translation
    startingX = xDist - 0.05; %left 5cm boundary 
    minXCount = intmax; %init min value
    MatrixX = zeros(10,1);
    SmallestMatrixX = zeros(10,1);
    indexX = 1;
    
    %start from left 5cm boundary and iterate to right 5cm boundary
    for i = 1 : 100
        A = [1, 0, 0, 0;
             0, 1, 0, 0;
             0, 0, 1, 0;
             startingX, 0, zDist, 1];
        tform = affine3d(A);
        pctest = pctransform(pcInput, tform);
        pcMerged = pcmerge(pcRef, pctest, mergeSize);
        MatrixX(i) = startingX;
        
        %replace if the temporary merged PC is smaller 
        if (pcMerged.Count < minXCount)
            minXCount = pcMerged.Count;
            xDist = startingX;
            SmallestMatrixX(indexX) = startingX;
            indexX = indexX + 1;
        end
        
        %increments startingX by 0.001 to shift PC
        startingX = startingX + 0.001;
    end

    %find optimal z axis translation
    startingZ = zDist - 0.05; %bottom 5cm boundary
    minZCount = intmax; %init min value
    MatrixZ = zeros(10,1);
    SmallestMatrixZ = zeros(10,1);
    indexZ = 1;
    
    %start from bottom 5cm boundary and iterate to top 5cm boundary
    for i = 1 : 100
        A = [1, 0, 0, 0;
             0, 1, 0, 0;
             0, 0, 1, 0;
             xDist, 0, startingZ, 1];
        tform = affine3d(A);
        pctest = pctransform(pcInput, tform);
        pcMerged = pcmerge(pcRef, pctest, mergeSize);
        MatrixZ(i) = startingZ;
        
        %replace if the temporary merged PC is smaller 
        if (pcMerged.Count < minZCount)
            minZCount = pcMerged.Count;
            zDist = startingZ;
            SmallestMatrixZ(indexZ) = startingZ;
            indexZ = indexZ + 1;
        end

        %increments startingZ by 0.001 to shift PC
        startingZ = startingZ + 0.001;
    end
    
    %performs merge with optimal translation values
    A = [1, 0, 0, 0;
         0, 1, 0, 0;
         0, 0, 1, 0;
         xDist, 0, zDist, 1];
    tform = affine3d(A);
    pcInput = pctransform(pcInput, tform);
    
    %returns the merged PC
    pcMerged = pcmerge(pcRef, pcInput, mergeSize);
end