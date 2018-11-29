% --------------------------------------------------------
% Fast R-CNN
% Copyright (c) 2015 Microsoft
% Licensed under The MIT License [see LICENSE for details]
% Written by Ross Girshick
% --------------------------------------------------------

function model = fast_rcnn_load_net()
% Load a Fast R-CNN network.
use_gpu = true;
def = '.\caffe\model\Fast_Rcnn_test.prototxt';
net =  '.\caffe\fast_rcnn\fast_rcnn_models\vgg16_fast_rcnn_iter_40000.caffemodel';
init_key = caffe.Net(def, net, 'test');
if exist('use_gpu', 'var') && ~use_gpu
  caffe.set_mode_cpu();
else
  caffe.set_mode_gpu();
  caffe.set_device(0);
end

model.init_key = init_key;
% model.stride is correct for the included models, but may not be correct
% for other models!
model.stride = 16;
model.pixel_means = reshape([102.9801, 115.9465, 122.7717], [1 1 3]);
