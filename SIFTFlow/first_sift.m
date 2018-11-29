function left_average = first_sift(ImageName,para,ImgIndex,average,mode,cellsize,gridspacing,SIFTflowpara)  
left_average = [];
    curFramePicture_Pick = imresize(imread(['.\sequence\' mode '\' ImageName]),[50,50]);
    cursift_Pick = mexDenseSIFT(uint8(curFramePicture_Pick),cellsize,gridspacing);
    index = ceil(ImgIndex/7);
%     if index < 3
%        ii = [1,2,3,4];
%     else
%         ii = [index-2,index-1,index+1,index+2];
%     end
%     if index > para.BatchNum-3
%         ii=[para.BatchNum-1, para.BatchNum-1 ,para.BatchNum ,para.BatchNum];
%     end
    if index < 2
       ii = [1,2];
    else
        ii = [index-1,index+1];
    end
    if index > para.BatchNum-2
        ii=[para.BatchNum-1 ,para.BatchNum];
    end
    
    for i = 1:2
         weight_mean_all = [];
        for j = 1:3
        index_cell =  average(ii(1,i));
        latImaName = para.Files(index_cell{1}(j,1)).name;
        Low = imresize(imread([para.LowlevelSaliencyPath latImaName(1:end-4) '.jpg']),[50, 50]);
        Low = im2bw(Low, graythresh(Low));       %对图像二值化
        latFramePicture= imresize(imread(['.\sequence\' mode '\' latImaName]),[50, 50]);
        Latsift = mexDenseSIFT(uint8(latFramePicture),cellsize,gridspacing);

        [vx,vy,~]=SIFTflowc2f(cursift_Pick,Latsift,SIFTflowpara);
        ErrorM=ErrorMatrix1(cursift_Pick,Latsift,vx,vy);
        weight_mean = [sum(sum((1-ErrorM) .* Low)) / sum(sum(Low)),index_cell{1}(j,1)];
        weight_mean_all = [weight_mean_all; weight_mean];
        end
        mm=sortrows(weight_mean_all,1); y = mm(end,2);
        if y == ImgIndex 
            y = mm(end-1, 2); 
        end
        left_average = [left_average, y];
    end
end