function FinelevelSIFTFlow(para,mode,scale)
        caffe.reset_all();
        rcnn_model = fast_rcnn_load_net();%load model
        Files = para.Files;
        for img_index = 1:para.LengthFiles-1                       
            ImageName = Files(img_index).name;
            curFrame_picture = imresize(imread(['.\sequence\' mode '\' ImageName]),[300,300]);

            curFrame_Low = normalizeMatrix(single(imread([para.LowlevelSaliencyPath ImageName(1:end-4) '.jpg'])));
            curFrame_Mot = normalizeMatrix(single(imread([para.SmoothedMotionSaliencyPath ImageName(1:end-4) '.jpg'])));
            curFrame_OP = load([para.OpticalFlowPath ImageName(1:end-4) '.mat']);
            curFrame_LOM(:,:,1) = curFrame_Low.*255;
            curFrame_LOM(:,:,2) = normalizeMatrix(sqrt(curFrame_OP.vx.^2 + curFrame_OP.vy.^2)); 
            curFrame_LOM(:,:,3) = curFrame_Mot.*255;

            all_datalabel = load([para.ImageRectPath ImageName(1:end-4) '.mat']);
            all_datalabel = all_datalabel.all_datalabel;
            boxes_1 = [all_datalabel{2}(:,2:5);all_datalabel{2}(:,6:9)];
           boxes_2 = all_datalabel{2}(:,2:5);
            num2 = length(all_datalabel{2});
            label_2 = single(all_datalabel{2}(:,1)); 
            rcnnfeat_1 = fast_rcnn_im_detect(curFrame_picture,boxes_1, rcnn_model,para,img_index);
            rcnnfeat_2 = fast_rcnn_im_detect(curFrame_LOM,boxes_2, rcnn_model,para,img_index);
                        y2 = num2*2; 
            allbatchfeas{2} = [label_2,rcnnfeat_1(num2+1:y2,:),rcnnfeat_1(1:num2,:),rcnnfeat_2];
            allbatchfeas{4} = num2;
           save([para.ImageRectPath ImageName(1:end-4) '_feas.mat'],'allbatchfeas');
           clear allbatchfeas;
           fprintf('frame %d done!\n', img_index)   
        end
         caffe.reset_all();
end