function GetBoxesInfo(vote,scale,ImgIndex,para,mode,average,N)
Files = para.Files;
ImageName = Files(ImgIndex).name;

latFramePicture= imresize(imread(['.\sequence\' mode '\' ImageName]),[300,300]);
latRect = load([para.RPNBoxPath 'Boxes_all.mat']);
latRect = latRect.Boxes_all(ImgIndex, :);
orilatximage = latFramePicture(latRect(1,1):latRect(1,2),latRect(1,3):latRect(1,4),:);
latximage(:,:,:) = imresize(orilatximage,[150,150]);
[LatSPInfo.LatSPInfo, SP_all] = SLIC_Sift(latximage,para,ImageName,latRect);
LatSPInfo.latRect = latRect;  LatSPInfo.latximage = latximage;

save([para.RectSPInfoPath ImageName(1:end-4) '.mat'],'LatSPInfo');
save([para.RectSPInfoPath ImageName(1:end-4) 'SP_all.mat'],'SP_all');
end