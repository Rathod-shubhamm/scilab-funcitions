# scilab-funcitions

Overview
The imapplymatrix function in Scilab takes an input multi-channel image (e.g., RGB) along
with a transformation matrix and applies that transformation to correspondingly and
independently each pixel in each channel of the image and outputs the resultant image.
This is a common operation in image processing tasks such as color space conversion
and application of colour transformation matrices.Specifically to each pixel on the input
image X, it transforms it using matrix M followed by possible adding of vector C (typically
used for color-shift or bias). Y is the transformed image returned.
