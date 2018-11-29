function computeMotionSaliency(mode,ImgIndex,para)
        Files = para.Files;
        ImageName = Files(ImgIndex).name;
        SP = load([para.SuperPixelStructurePath ImageName(1:end-4) '.mat']);
        SP = SP.SP{1};

        Ranges = ones(SP.SuperPixelNumber,2);
        Ranges(:,1) = 50;
        Ranges(:,2) = Ranges(:,2)*300;
        AdjMatrix = computeSuperPixelAdj(SP,Ranges);
        MotionFeatureDistMatrix = zeros(SP.SuperPixelNumber,SP.SuperPixelNumber);
        spnum = double(SP.SuperPixelNumber);
        MiddlePoint = double(SP.MiddlePoint(:,end-1:end));
        MotionFeatureDistMatrix = ComputeMotFeatDistMatrix(MiddlePoint,spnum);

        [index] = find(AdjMatrix(:)==0);
        MotionFeatureDistMatrix(index)=0;
        MotionFeatureDistMatrix = MotionFeatureDistMatrix./(AdjMatrix+1);

        MotionSaliencyResult = sum(abs(MotionFeatureDistMatrix));

        for i=1:SP.SuperPixelNumber
            PixelPoolNum = SP.ClusteringPixelNum(1,i);
            PixelXIndexPool = SP.Clustering(i,1:PixelPoolNum,1);
            PixelYIndexPool = SP.Clustering(i,1:PixelPoolNum,2);
            for ii=1:PixelPoolNum
                MotionSaliencyMap(PixelXIndexPool(1,ii),PixelYIndexPool(1,ii)) = MotionSaliencyResult(1,i);
            end
        end
       MotionSaliencyMap = normalizeMatrix(MotionSaliencyMap);
       SMSR = im2bw(imresize(MotionSaliencyMap,[150,150]), graythresh(MotionSaliencyMap));       
       persent = sum(sum(SMSR==1))/22500;
        save([para.AveragePath ImageName(1:end-4) 'persent.mat'],'persent');
        MotionSaliencyResult = normalizeMatrix(MotionSaliencyResult);
        MotionSaliencyResult(find(MotionSaliencyResult<0.2))=0;
       MRS = MotionSaliencyResult;

       save([para.MotionSaliencyPath ImageName(1:end-4) '_Motion.mat'],'MRS');
       imwrite(MotionSaliencyMap,[para.MotionSaliencyPath ImageName(1:end-4) '.jpg']);
       fprintf('frame %d done!\n', ImgIndex);
end