// Scilab implementation of rgb2xyz

function [X, Y, Z] = rgb2xyz(varargin)
    
    nargs = argn(2);

    if nargs == 1 then
        input = varargin(1);
        // Veriying if the input image is an RGB image (3d image)
        dims = size(input);
        if length(dims) == 3 && dims(3) == 3 then
            
            R = input(:,:,1);
            G = input(:,:,2);
            B = input(:,:,3);
        else
            error("Input must be an RGB image");
        end
    elseif nargs == 3 then
        // Separate R, G, B inputs
        R = varargin(1);
        G = varargin(2);
        B = varargin(3);
    else
        error("Single RGB image expected");
    end

    //Verifying if the values are in the range of [0,255]
    R = double(max(0, min(255, R)));
    G = double(max(0, min(255, G)));
    B = double(max(0, min(255, B)));

    // Transformation to the range [0,1]
    R = R / 255;
    G = G / 255;
    B = B / 255;

    // Gamma correction 
    function gamma_corrected = apply_gamma_correction(channel)
        mask = channel > 0.04045;
        gamma_corrected = mask .* ((channel + 0.055) / 1.055) .^ 2.4 + (~mask .* (channel / 12.92));
    endfunction

    R = apply_gamma_correction(R);
    G = apply_gamma_correction(G);
    B = apply_gamma_correction(B);

    // Conversion to XYZ using D65
    X = R * 0.4124564 + G * 0.3575761 + B * 0.1804375;
    Y = R * 0.2126729 + G * 0.7151522 + B * 0.0721750;
    Z = R * 0.0193339 + G * 0.1191920 + B * 0.9503041;

    // matching D65 refrence poits
    X = X * 200;
    Y = Y * 250;
    Z = Z * 200;
    // Normalization and visualization 
   X = max(0, min(255, X));
   Y = max(0, min(255, Y));
   Z = max(0, min(255, Z));
endfunction
