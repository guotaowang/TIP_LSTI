  function smooth = GetSPSmoothInfo(vote,scale,para,mode)
SPnum = [];      LengthFiles = para.LengthFiles-1;     Files = para.Files;
for i=1:LengthFiles
        ImageName = Files(i).name;
        SP_num = load([para.RectSPInfoPath ImageName(1:end-4) 'SP_all.mat']);
        SP_num = double(SP_num.SP_all);
        SPnum = [SPnum; SP_num];
end
      MaxDim = double(max(SPnum,[],1));
     ring{2} = zeros(MaxDim,7*LengthFiles); 
     for ImgIndex=1:LengthFiles
            ImageName = Files(ImgIndex).name;
            LatSPInfo = load([para.RectSPInfoPath ImageName(1:end-4) '.mat']);
             I{ImgIndex}=LatSPInfo.LatSPInfo.latximage;
             SP2= SPnum(ImgIndex,1); 
             SP_all{2}(ImgIndex) = LatSPInfo.LatSPInfo.LatSPInfo{2};
             ring{2}(1:SP2,(ImgIndex-1)*7+1:ImgIndex*7) = LatSPInfo.LatSPInfo.LatSPInfo{2}.MiddlePoint(:,1:7);
     end
     smooth.ring = ring;  smooth.SP_all = SP_all;    smooth.SP_num = SPnum;   smooth.MaxDim = MaxDim;
     smooth.all_I = I; 
  end