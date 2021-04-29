function pcMin = myMin(x, y, pcInput, pcTotal)
% - x how far in the X-axis the Point Cloud is away from the Merged Point
% Cloud
% - y how far in the Y-axis the Point Cloud is away from the Merged Point
% Cloud
% - pcInput is the Point Cloud that needs to be moved to the correct place
% - pcTotal is the currently Merged Point Cloud that will merge with the
% pcInput

% Given (starting) mergeSize
mergeSize = 0.001;

% Translates the point cloud
% Note: Translation checks for 10 cm (starts at -0.05 and ends at -0.05)

% Start with the x part
% Decrements x by 0.05 and prepares to translate it by 0.01 to check for
% the smallest point cloud possible
startingX = x - 0.05;

% Dummy value for smallest
smallest = 100000000000;
MatrixX = zeros(10,1);
index = 1;
SmallestMatrixX = zeros(10,1);
indexX = 1;
smallest2nd = 0;
x2 = 0;
trueX = 0;
smallest3rd = 0;
x3 = 0;
for i = 1 : 10
    A = [1, 0, 0, 0;
         0, 1, 0, 0;
         0, 0, 1, 0;
         startingX, 0, y, 1];
    tform = affine3d(A);
    pctest = pctransform(pcInput, tform);
    pcMerged = pcmerge(pcTotal, pctest, mergeSize);
    MatrixX(index) = startingX;
    index = index + 1;
    % If the temporary merged point cloud is smaller than the smallest
    % number currently, replace
    if (pcMerged.Count < smallest)
        smallest3rd = smallest2nd;
        smallest2nd = smallest;
        smallest = pcMerged.Count;
        x3 = x2;
        x2 = x;
        x = startingX;
        SmallestMatrixX(indexX) = startingX;
        indexX = indexX + 1;
    end
    
    if (pcMerged.Count < smallest2nd && pcMerged.Count > smallest)
        trueX = startingX;
    end
    
    % Increments startingX by 0.01 to check for next shift
    startingX = startingX + 0.01;

end

% Does the y part
% Decrements y by 0.05 and prepares to translate it by 0.01 to check for
% the smallest point cloud possible

startingY = y - 0.05;
smallest = 100000000000;
MatrixY = zeros(10,1);
index = 1;
SmallestMatrixY = zeros(10,1);
indexY = 1;
smallest2nd = 0;
y2 = 0;
trueY = 0;  
smallest3rd = 0;
y3 = 0;
for i = 1 : 10
    A = [1, 0, 0, 0;
         0, 1, 0, 0;
         0, 0, 1, 0;
         x, 0, startingY, 1];
    tform = affine3d(A);
    pctest = pctransform(pcInput, tform);
    pcMerged = pcmerge(pcTotal, pctest, mergeSize);
    MatrixY(index) = startingY;
    index = index + 1;
    % If the temporary merged point cloud is smaller than the smallest
    % number currently, replace
    if (pcMerged.Count < smallest)
        smallest3rd = smallest2nd;
        smallest2nd = smallest;
        smallest = pcMerged.Count;
        y3 = y2;
        y2 = y;
        y = startingY;
        SmallestMatrixY(indexY) = startingY;
        indexY = indexY + 1;
        
    end
   
    % Increments startingY by 0.01 to check for next shift
    startingY = startingY + 0.01;

end

% Sorts all the x and y values used for the Matrix
% MatrixX = sort(MatrixX);
% MatrixY = sort(MatrixY);

% 2nd smallest value for x is used (because it produces best results)
% 1st, 2nd, and 3rd smallest values of x is available however
% x is smallest, x2 is 2nd smallest, x3 is 3rd smallest
x = x2;

% Smallest value of y is used (because it produces best results)
% 1st, 2nd, and 3rd smallest values of y is available however
% y is smallest, y2 is 2nd smallest, y3 is 3rd smallest
% y = y

% Smallest Point Cloud possible with x and y are found
% Constructs the Point Cloud with these values and 
% merges with the current Total Merged Cloud
A = [1, 0, 0, 0;
     0, 1, 0, 0;
     0, 0, 1, 0;
     x, 0, y, 1];
tform = affine3d(A);
pcInput = pctransform(pcInput, tform);

% Returns the Total Merged Cloud
pcMin = pcmerge(pcTotal, pcInput, mergeSize);

end