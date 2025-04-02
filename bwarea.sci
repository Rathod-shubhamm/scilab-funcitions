function area = bwarea(bw)
    // Ensure the input is a binary 2D matrix
    dims = size(bw);
    if length(dims) > 2 then
        error("Input must be a binary image (2D matrix).");
    endfunction

    // Convert to double and ensure only 0s and 1s are present
    bw = double(bw); // Force to numeric type
    if sum(bw(:) ~= 0 & bw(:) ~= 1) > 0 then
        error("Input must be a binary image containing only 0s and 1s.");
    endfunction

    // Pad the binary image to handle edge cases
    bw_padded = padarray(bw, [1, 1], 0);

    // Define 2x2 masks for specific configurations
    mask_full = [1, 1; 1, 1];
    mask_diag = [1, 0; 0, 0];
    mask_half = [1, 1; 0, 0];
    mask_lshape = [1, 0; 1, 0];

    // Perform 2D convolutions with each mask
    conv_full = conv2(bw_padded, mask_full, 'valid');
    conv_diag = conv2(bw_padded, mask_diag, 'valid');
    conv_half = conv2(bw_padded, mask_half, 'valid');
    conv_lshape = conv2(bw_padded, mask_lshape, 'valid');

    // Calculate the area
    area = sum(conv_full == 4) + 0.5 * sum(conv_half == 2) + ...
           0.25 * sum(conv_lshape == 2) + sum(conv_diag == 1);
endfunction

function padded_img = padarray(img, pad_size, pad_value)
    // img: input matrix (image)
    // pad_size: [rows, cols] to pad
    // pad_value: value to pad with

    [rows, cols] = size(img);

    // Create a new matrix with padding
    padded_img = pad_value * ones(rows + 2 * pad_size(1), cols + 2 * pad_size(2));

    // Place the original image in the center
    padded_img(pad_size(1) + 1:rows + pad_size(1), pad_size(2) + 1:cols + pad_size(2)) = img;
endfunction
