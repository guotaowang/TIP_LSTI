%======================================================================
%SLIC demo
% Copyright (C) 2015 Ecole Polytechnique Federale de Lausanne
% File created by Radhakrishna Achanta
% Please also read the copyright notice in the file slicmex.c 
%======================================================================
%Input parameters are:
%[1] 8 bit images (color or grayscale)
%[2] Number of required superpixels (optional, default is 200)
%[3] Compactness factor (optional, default is 10)
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
%======================================================================
img = imread('4475-1_70559  .jpg');
figure;imshow(img,[]);
sigma_s = 100;sigma_r = 0.1;%Smoothing Parameter
img = RF(im2double(img), sigma_s, sigma_r);%Image Preprocessing/Smoothing
figure;imshow(img,[]);
 
[labels, numlabels] = slicmex(im2uint8(img),500,1);%numlabels is the same as number of superpixels
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


