function GetBoundingBoxes(vote,scale,ImgIndex,para,mode)
        Files = para.Files;
        ImageName = Files(ImgIndex).name;
        
         spcorrspd = load([para.SiftFlowPath ImageName(1:end-4) '.mat']); spcorrspd = spcorrspd.spcorrspd ; cur_middle = spcorrspd.cur_middle;
        curFrame_picture = imresize(imread(['sequence\' mode '\' ImageName]),[300,300]);
       for scale_index = 2:2
            SPMiddlePoint = floor(cur_middle{scale_index}(:,1:2));
                all_Rect = [];
                length = size(SPMiddlePoint,1);
                 for i_1=1:length
                        rect_1 = [max(SPMiddlePoint(i_1,1)-(13-3*(scale_index-1)),0),min(SPMiddlePoint(i_1,1)+(13-3*(scale_index-1)),300),max(SPMiddlePoint(i_1,2)-(13-3*(scale_index-1)),0),min(SPMiddlePoint(i_1,2)+(13-3*(scale_index-1)),300)];
                        rect_1 = rect_1(:, [3 1 4 2]);
                        rect_1_1 = [max(SPMiddlePoint(i_1,1)-(55-5*(scale_index-1)),0),min(SPMiddlePoint(i_1,1)+(55-5*(scale_index-1)),300),max(SPMiddlePoint(i_1,2)-(55-5*(scale_index-1)),0),min(SPMiddlePoint(i_1,2)+(55-5*(scale_index-1)),300)];
                        rect_1_1 = rect_1_1(:, [3 1 4 2]);
                        Curlabel = i_1;
                        rect = [Curlabel rect_1 rect_1_1];
                        all_Rect = [all_Rect; rect];
                end
                all_datalabel{scale_index} = all_Rect;
       end 
           save([para.ImageRectPath ImageName(1:end-4) '.mat'],'all_datalabel');
           fprintf('frame %d done!\n', ImgIndex)   
end
        