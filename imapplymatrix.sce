// Scilab implementation
function Y = imapplymatrix(M, X, C)
    // Verifying input dimension
    [m, n, p] = size(X);
    [q, pM] = size(M);
    if p <> pM then
        error("Matrix M  must have the same number of columns as no of color channels image has");
    end
    
    if argn(2) < 3 then
        C = zeros(q, 1); 
    end
    
    if length(C) <> q then
        error("C must be a vector of length that is equal to the number of output channels (rows in M).");
    end
    
    
    Y = zeros(m, n, q);
    
    // Transformation
    for i = 1:m
        for j = 1:n
            pixel = X(i, j, :);
            pixel = matrix(pixel, [p, 1]); 
            Y(i, j, :) = M * pixel + C;
        end
    end
endfunction
