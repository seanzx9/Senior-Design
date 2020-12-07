function f = stitch(I1, I2)
    %get x, y, z and size values for I1
    [n1, m1] = size(I1);
    x1 = I1(:, 1);
    y1 = I1(:, 2);
    z1 = I1(:, 3);
    
    %get x, y, z and size values for I2
    [n2, m2] = size(I2);
    x2 = I2(:, 1);
    y2 = I2(:, 2);
    z2 = I2(:, 3);
      
    f = I1;
end