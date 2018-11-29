function computeOpticalFlow(ImgIndex,para)
alpha = 0.012;%0.012
ratio = 0.75;%0.75
minWidth = 20;%20
nOuterFPIterations = 7;%7
nInnerFPIterations = 1;%1
nSORIterations = 30;%30
OpticalFlowPara = [alpha,ratio,minWidth,nOuterFPIterations,nInnerFPIterations,nSORIterations];
sigma_s = 100;sigma_r = 0.2;%RF Smoothing Parameter

path = para.path;
Files = para.Files;
   ImageName1 = Files(ImgIndex).name;
   ImagePath1 = [path ImageName1];
   I1 = imread(ImagePath1);
   ImageName2 = Files(ImgIndex+1).name;
   ImagePath2 = [path ImageName2];
   I2 = imread(ImagePath2);
   I1 = imresize(I1,[150,150]);
   I2 = imresize(I2,[150,150]);
   ISmoothed1 = RF(im2double(I1), sigma_s, sigma_r);
   ISmoothed2 = RF(im2double(I2), sigma_s, sigma_r);
   [vx,vy,warpI2] = Coarse2FineTwoFrames(ISmoothed1,ISmoothed2,OpticalFlowPara);
   vx = imresize(vx,[300,300],'bilinear');
   vy = imresize(vy,[300,300],'bilinear');
  CurrentOpticalFlow.vx = normalizeMatrix(vx);
  CurrentOpticalFlow.vy = normalizeMatrix(vy);
   save([para.OpticalFlowPath ImageName1(1:end-4) '.mat'],'-struct','CurrentOpticalFlow');
   fprintf('frame %d done!\n', ImgIndex-2);

