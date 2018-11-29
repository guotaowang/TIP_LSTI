% --------------------------------------------------------
% Fast R-CNN
% Copyright (c) 2015 Microsoft
% Licensed under The MIT License [see LICENSE for details]
% Written by Ross Girshick
% --------------------------------------------------------

function blobs_out = fast_rcnn_im_detect(im, boxes,model,para,img_index)
% tic
im = imresize(im,[300,300]);
[im_batch, scales] = image_pyramid(im, model.pixel_means, false);
raw= size(boxes,1);
boxes_compute = zeros(2000, 4);
boxes_compute(1:raw,:) = single(boxes);
[feat_pyra_boxes, feat_pyra_levels] = project_im_rois(boxes_compute, scales);
% for mm=1:raw
%     figure(1); showboxes(im, boxes(mm,:));
%     figure(2); showboxes(im_batch, feat_pyra_boxes(mm,:));
% end
rois = cat(2, feat_pyra_levels, feat_pyra_boxes);
% Adjust to 0-based indexing and make roi info the fastest dimension
rois = rois - 1;
rois = permute(rois, [2 1]);
rois(rois<0)=0;
input_blobs = cell(2, 1);
input_blobs{1} = im_batch;
imwrite(im_batch, [para.LOMPath num2str(img_index) '.jpg']);
input_blobs{2} = rois;

blobs_out = model.init_key.forward(input_blobs);
blobs_out = blobs_out{1}(:,1:raw)';
% fprintf('fwd: %.3fs\n', toc);

% ------------------------------------------------------------------------
function [batch, scales] = image_pyramid(im, pixel_means, multiscale)
% ------------------------------------------------------------------------
% Construct an image pyramid that's ready for feeding directly into caffe
if ~multiscale
  SCALES = [600];
  MAX_SIZE = 2000;
else
  SCALES = [1200 864 688 576 480];
  MAX_SIZE = 2000;
end
num_levels = length(SCALES);

im = single(im);
% Convert to BGR
im = im(:, :, [3 2 1]);
% Subtract mean (mean of the image mean--one mean per channel)
im = bsxfun(@minus, im, pixel_means);

im_orig = im;
im_size = min([size(im_orig, 1) size(im_orig, 2)]);
im_size_big = max([size(im_orig, 1) size(im_orig, 2)]);
scale_factors = SCALES ./ im_size;

max_size = [0 0 0];
for i = 1:num_levels
  if round(im_size_big * scale_factors(i)) > MAX_SIZE
    scale_factors(i) = MAX_SIZE / im_size_big;
  end
  ims{i} = imresize(im_orig, scale_factors(i), 'bilinear', ...
                    'antialiasing', false);
  max_size = max(cat(1, max_size, size(ims{i})), [], 1);
end

batch = zeros(max_size(2), max_size(1), 3, num_levels, 'single');
for i = 1:num_levels
  im = ims{i};
  im_sz = size(im);
  im_sz = im_sz(1:2);
  % Make width the fastest dimension (for caffe)
  im = permute(im, [2 1 3]);
  batch(1:im_sz(2), 1:im_sz(1), :, i) = im;
end
scales = scale_factors';

% ------------------------------------------------------------------------
function [boxes, levels] = project_im_rois(boxes, scales)
% ------------------------------------------------------------------------
widths = boxes(:,3) - boxes(:,1) + 1;
heights = boxes(:,4) - boxes(:,2) + 1;

areas = widths .* heights;
scaled_areas = bsxfun(@times, areas, (scales.^2)');
diff_areas = abs(scaled_areas - (224 * 224));
[~, levels] = min(diff_areas, [], 2);

boxes = boxes - 1;
boxes = bsxfun(@times, boxes, scales(levels));
boxes = boxes + 1;