function net = init_net()
caffe.set_mode_gpu();       
caffe.reset_all();
deploy = '.\caffe\model\LSTI_test.prototxt';    %3
% deploy = '.\caffe\model\LSTI_test_nosift.prototxt';   
%  caffe_model = 'D:\caffe\caffe-master\examples\mnist\nosiftflow\_iter_9000.caffemodel';    %4
caffe_model = 'D:\caffe\caffe-master\examples\mnist\model_most_recent\_iter_13000.caffemodel';
% caffe_model = 'E:\LSTI_AAAI2018\caffe\model\LSTI.caffemodel';
net = caffe.Net(deploy, caffe_model, 'test');    