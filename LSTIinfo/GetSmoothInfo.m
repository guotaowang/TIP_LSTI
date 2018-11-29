  function [MotSaliencyM,smooth,SP_all,I,MaxDim,SPnum] = GetSmoothInfo(vote,scale,para,mode)
SPnum = [];      LengthFiles = para.LengthFiles-1;     Files = para.Files;
for i=1:LengthFiles
        ImageName = Files(i).name;
        SP_num = load([para.SuperPixelStructurePath ImageName(1:end-4) 'SP_all.mat']);
        SP_num = double(SP_num.SP_all);
        SPnum = [SPnum; SP_num];
end
      MaxDim = double(max(SPnum,[],1));
     tic
     MotSaliencyM = zeros(MaxDim,LengthFiles);  %3¸ÄÎª2
     ring{1} = zeros(MaxDim,7*LengthFiles);  
%      ring{2} = zeros(MaxDim(1,2),7*LengthFiles); 
     for ImgIndex=1:LengthFiles
            ImageName = Files(ImgIndex).name;
             I{ImgIndex}=imread(['.\sequence\' mode '\' ImageName]);
            SP = load([para.SuperPixelStructurePath ImageName(1:end-4) '.mat']);
             SP1= SPnum(ImgIndex,1); 
%              SP2= SPnum(ImgIndex,2); 
             SP_all{1}(ImgIndex) = SP.SP{1};   
%              SP_all{2}(ImgIndex) = SP.SP{2};
             ring{1}(1:SP1,(ImgIndex-1)*7+1:ImgIndex*7) = SP.SP{1}.MiddlePoint(:,1:7);
%              ring{2}(1:SP2,(ImgIndex-1)*7+1:ImgIndex*7) = SP.SP{2}.MiddlePoint(:,1:7);
             MotResult = load([para.MotionSaliencyPath ImageName(1:end-4) '_Motion.mat']);
             MotResult = normalizeMatrix(MotResult.MRS');
             MotSaliencyM(1:SP1,ImgIndex) = MotResult;
     end
     smooth.ring = ring;  smooth.SP_all = SP_all;    smooth.SP_num = SPnum;   smooth.MaxDim = MaxDim;
     smooth.all_I = I; 
     MotSaliencyM = MatrixNormalization(MotSaliencyM);
  end