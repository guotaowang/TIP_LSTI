%======================================================================
%SLICO demo
% Copyright (C) 2015 Ecole Polytechnique Federale de Lausanne
% File created by Radhakrishna Achanta
% Please also read the copyright notice in the file slicmex.c 
%======================================================================
%Input:
%[1] 8 bit images (color or grayscale)
%[2] Number of required superpixels (optional, default is 200)
%
%Ouputs are:
%[1] labels (in raster scan order)
%[2] number of labels in the image (same as the number of returned
%superpixels
%
%NOTES:
%[1] number of returned superpixels may be different from the input
%number of superpixels.
%[2] you must compile the C file using mex slicmex.c before using the code
%below
%----------------------------------------------------------------------
% How is SLICO different from SLIC?
%----------------------------------------------------------------------
% 1. SLICO does not need compactness factor as input. It is calculated
% automatically
% 2. The automatic value adapts to the content of the superpixel. So,
% SLICO is better suited for texture and non-texture regions
% 3. The advantages 1 and 2 come at the cost of slightly poor boundary
% adherences to regions.
% 4. This is also a very small computational overhead (but speed remains
% almost as fast as SLIC.
% 5. There is a small memory overhead too w.r.t. SLIC.
% 6. Overall, the advantages are likely to outweigh the small disadvantages
% for most applications of superpixels.
%======================================================================
%img = imread('someimage.jpg');
img = imread('img.jpg');
figure;imshow(img,[]);
sigma_s = 100;sigma_r = 0.1;%Smoothing Parameter
img = RF(im2double(img), sigma_s, sigma_r);%Image Preprocessing/Smoothing
figure;imshow(img,[]);
 
[labels, numlabels] = slicomex(im2uint8(img),80);%numlabels is the same as number of superpixels
% figure;
% imagesc(labels);

[row col] = size(labels);
result = zeros(row,col,3);
result = img;
for i=2:row-1
    for j=2:col-1
        flag = 0;
        if(labels(i-1,j-1)~=labels(i,j))
            flag = 1;
        end
                if(labels(i-1,j)~=labels(i,j))
            flag = 1;
                end
                if(labels(i-1,j+1)~=labels(i,j))
            flag = 1;
                end
                if(labels(i,j-1)~=labels(i,j))
            flag = 1;
                end
                if(labels(i,j+1)~=labels(i,j))
            flag = 1;
                end
                if(labels(i+1,j-1)~=labels(i,j))
            flag = 1;
                end
                        if(labels(i+1,j-1)~=labels(i,j))
            flag = 1;
                        end
                        if(labels(i+1,j-1)~=labels(i,j))
            flag = 1;
                        end
        if(flag==1)
            result(i,j,:) = [255,0,0]';
        end
    end
end
imshow(result)
      








