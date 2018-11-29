function [SP, SP_all] = SLIC_Sift(Image,para,ImageName,Rect)
   sigma_s = 100;sigma_r = 0.1;
   ISmoothed = RF(im2double(Image), sigma_s, sigma_r);
    IHsv = rgb2hsv(ISmoothed);
    ISmoothed_1= ISmoothed(:,:,1);    ISmoothed_2= ISmoothed(:,:,2);    ISmoothed_3= ISmoothed(:,:,3);
    IHsv_1= normalizeMatrix(IHsv(:,:,1));  IHsv_2= normalizeMatrix(IHsv(:,:,2));  
   spnum = 400;
   SP_all = [];
   for scale_index = 2:2
       [SEGMENTS2, numlabels] = slicmex(im2uint8(ISmoothed),spnum,1);
       SEGMENTS2 = SEGMENTS2 + 1; 

       Clustering = zeros(numlabels,100,2);
       ClusteringPixelNum= zeros(1, numlabels);
       for i = 1:numlabels
          [raw, col]= find(SEGMENTS2 == i);
          m = [raw, col];
          [ClusteringPixelNum(i),~] = size(raw);
          Clustering(i,1:ClusteringPixelNum(i),:) = m;     
          index= find(SEGMENTS2(:) == i);
          MiddlePoint(i,:) = mean([m, ISmoothed_1(index), ISmoothed_2(index), ISmoothed_3(index), IHsv_1(index), IHsv_2(index)]);
       end
       SP2{scale_index}.Clustering = Clustering;
       SP2{scale_index}.SEGMENTS = SEGMENTS2;
       SP2{scale_index}.SuperPixelNumber = max(max(SEGMENTS2));
       SP_all = [SP_all, max(max(SEGMENTS2))];
       SP2{scale_index}.ClusteringPixelNum = ClusteringPixelNum;
       SP2{scale_index}.MiddlePoint = MiddlePoint;
       SP2{scale_index}.Rect = Rect;

       spnum = spnum + 200;
   end
   SP = SP2;
end