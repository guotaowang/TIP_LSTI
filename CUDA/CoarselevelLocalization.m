function CoarselevelLocalization(vote,scale,ImgIndex,para,mode,average)
Files = para.Files;
ImageName = Files(ImgIndex).name;
%% para
    cellsize=3;gridspacing=1;SIFTflowpara.alpha=2*255;SIFTflowpara.d=40*255;SIFTflowpara.gamma=0.005*255;
    SIFTflowpara.nlevels=4;SIFTflowpara.wsize=2;SIFTflowpara.topwsize=10;SIFTflowpara.nTopIterations = 60;
    SIFTflowpara.nIterations= 30;
%% CurFrame
    curSPInfo = load([para.RectSPInfoPath ImageName(1:end-4) '.mat']); 

%% NextFrames
    left_average = first_sift(ImageName,para,ImgIndex,average,mode,cellsize,gridspacing,SIFTflowpara);
     for index = 1:2
            latImaName{index} = Files(left_average(index)).name;
            latSPInfo{index}= load([para.RectSPInfoPath latImaName{index}(1:end-4) '.mat']);
     end
%% local siftflow£¨Second siftflow£©
     second_sift(para,ImgIndex,ImageName,latImaName,curSPInfo,latSPInfo,SIFTflowpara,left_average);
