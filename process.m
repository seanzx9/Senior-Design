%bound data values and subtract extra points
function out = process(data)  
    [n, m] = size(data);
    
    %set bounds in data and remove extra
    f = zeros(n, m);
    for i = 1 : n
        if data(i, 1) >= -0.15 && data(i, 1) <= 0.15 &&... %x bounds
           data(i, 2) >= 0 && data(i, 2) <= 1 &&...        %y bounds
           data(i, 3) >= 0.3 && data(i, 3) <= 0.45         %z bounds
            f(i, 1) = data(i, 1);
            f(i, 2) = data(i, 2);
            f(i, 3) = data(i, 3);
            f(i, 4) = data(i, 4);
            f(i, 5) = data(i, 5);
            f(i, 6) = data(i, 6);
        end
    end    
    
    %remove blue points
    for i = 1 : n
        if data(i, 4) < 65 &&...  %red channel
           data(i, 5) < 140 &&... %green channel
           data(i, 6) > 70        %blue channel
            f(i, 1) = 0;
            f(i, 2) = 0;
            f(i, 3) = 0;
            f(i, 4) = 0;
            f(i, 5) = 0;
            f(i, 6) = 0;
        end
    end
    
    %count valid points to preallocate
    count = 0;
    for i = 1 : n
        if f(i, 1) ~= 0 &&...
           f(i, 2) ~= 0 &&...
           f(i, 3) ~= 0
            count = count + 1;
        end
    end
    
    %output all valid points
    out = zeros(count, 6);
    ind = 1;
    for i = 1 : n
        if f(i, 1) ~= 0 &&...
           f(i, 2) ~= 0 &&...
           f(i, 3) ~= 0
            out(ind, 1) = f(i, 1);
            out(ind, 2) = f(i, 2);
            out(ind, 3) = f(i, 3);
            out(ind, 4) = f(i, 4);
            out(ind, 5) = f(i, 5);
            out(ind, 6) = f(i, 6);
            ind = ind + 1;
        end
    end
end