function ComputeLowlevelSaliency(computeCol,mode,ImgIndex,para)
LowlevelSaliencyPath = para.LowlevelSaliencyPath;
Files = para.Files;
       ImageName = Files(ImgIndex).name;   
       if computeCol == 1
                MotionSaliencyMap = normalizeMatrix(single(imread([para.SmoothedMotionSaliencyPath ImageName(1:end-4) '.jpg'])));
                ColorSaliencyMap = normalizeMatrix(single(imread([para.RawColorSaliencyPath ImageName(1:end-4) '.jpg'])));
                SMSR = im2bw(imresize(MotionSaliencyMap,[150,150]), graythresh(MotionSaliencyMap));      
                SCSR = im2bw(imresize(ColorSaliencyMap,[150,150]), graythresh(ColorSaliencyMap));  
                average = [ImgIndex  sum(sum(abs(SMSR .* SCSR)))];  
                LowlevelSaliency = normalizeMatrix(ColorSaliencyMap.*MotionSaliencyMap);
       else
                MotionSaliencyMap = normalizeMatrix(single(imread([para.MotionSaliencyPath ImageName(1:end-4) '.jpg'])));
                SMSR = im2bw(imresize(MotionSaliencyMap,[150,150]), graythresh(MotionSaliencyMap));   
                average = [ImgIndex  sum(sum(SMSR))];  
                LowlevelSaliency = normalizeMatrix(MotionSaliencyMap);
       end
       temp = imresize(LowlevelSaliency,[300 300]);
       imwrite(temp,[LowlevelSaliencyPath ImageName(1:end-4) '.jpg']);
        save([ para.AveragePath ImageName(1:end-4) 'average.mat'],'average');
       fprintf('frame %d done!\n', ImgIndex)          
end
