function computeColorContrastSaliency(para,mode,scale)
            caffe.set_mode_gpu();     
            caffe.reset_all();
             deploy =  '.\caffe\DSS-master\deploy.prototxt';
            caffe_model = '.\caffe\DSS-master\dss_model_released.caffemodel';  


            net = caffe.Net(deploy, caffe_model, 'test');   
            Files = para.Files;
            for img_index = 1:para.LengthFiles-1
                    ImageName = Files(img_index).name;
                    img = single( imresize(imread(['.\sequence\' mode '\' ImageName]),[500,500]));
                    tic
                    img(:,:,1) = img(:,:,1)-104.070;
                    img(:,:,2) = img(:,:,2)-116.660;
                    img(:,:,3) = img(:,:,3)-122.679;
                     img = permute(img, [2 1 3]);
                     image(:,:,:,1) = img;
                     image_ru{1} = image;
                     res = net.forward(image_ru);
                     sal = res{1} .*0.2+ res{2} .*0.2 + res{3} .* 0.2 + res{4} .*0.2 + res{5} .*0.1 + res{6} .*0.1 + res{7}.*0.2;
                      sal = normalizeMatrix(sal);
                     sal = imresize(rot90(sal',4),[300,300]);
                     toc
                      imwrite(sal,[para.RawColorSaliencyPath  ImageName(1:end-4) '.jpg']);
                      fprintf('frame %d done!\n', img_index);
            end
              caffe.reset_all();
end