function second_sift(para,ImgIndex,ImageName,latImaName,curSPInfo,latSPInfo,SIFTflowpara,left_average)  
     curximage = curSPInfo.LatSPInfo.latximage; curRect = curSPInfo.LatSPInfo.latRect;
     alpha1 = double((curRect(1,2)-curRect(1,1))/150);   beta1 = double((curRect(1,4)-curRect(1,3))/150);
     Cursift = mexDenseSIFT(curximage,3,1); 
     curSP = curSPInfo.LatSPInfo.LatSPInfo;
     for index = 1:2
       latximage = latSPInfo{index}.LatSPInfo.latximage; latRect = latSPInfo{index}.LatSPInfo.latRect;
        alpha2 = double((latRect(1,2)-latRect(1,1))/150);   beta2 = double((latRect(1,4)-latRect(1,3))/150);
        Latsift = mexDenseSIFT(latximage,3,1);
        latSP = latSPInfo{index}.LatSPInfo.LatSPInfo;
        [vx,vy,~]=SIFTflowc2f(Cursift,Latsift,SIFTflowpara);
        [ErrorM,XX,YY]=ErrorMatrix2(Cursift,Latsift,vx,vy);
        for scale_index = 2:2
            SP1 = curSP{scale_index}; SP2 = latSP{scale_index};
            cur_middle{scale_index}(:,1) = floor(SP1.MiddlePoint(:,1).*alpha1+curRect(1,1)-1);   cur_middle{scale_index}(:,2) = floor(SP1.MiddlePoint(:,2).*beta1+curRect(1,3)-1);
            i_2all = [];
            for i_1=1:SP1.SuperPixelNumber
                    im3=zeros(1,SP1.ClusteringPixelNum(1,i_1));
                    for j_1=1:SP1.ClusteringPixelNum(1,i_1)
                         im3(1,j_1) = SP2.SEGMENTS(YY(SP1.Clustering(i_1,j_1,1),SP1.Clustering(i_1,j_1,2)),XX(SP1.Clustering(i_1,j_1,1),SP1.Clustering(i_1,j_1,2)));
                    end
                    tabu1=tabulate(im3(:)); tabu1=sortrows(tabu1,2); tabus1=size(tabu1,1);
                    i_2 = tabu1(tabus1,1);   i_2all=[i_2all; i_2] ;
                    index_weight = find(SP2.SEGMENTS(:) == i_2);
                    spcorrspd_weight{scale_index}(i_1,index) = mean(ErrorM(index_weight));
                    spcorrspd_index{scale_index}(i_1,index) = i_2;
            end
            lat_middle{scale_index}(:,2*index-1) = floor(SP2.MiddlePoint(i_2all,1).*alpha2+latRect(1,1)-1);  lat_middle{scale_index}(:,2*index) = floor(SP2.MiddlePoint(i_2all,2).*beta2+latRect(1,3)-1);
        end
     end
    spcorrspd.spcorrspd_index = spcorrspd_index; 
    spcorrspd.cur_middle = cur_middle;   spcorrspd.lat_middle = lat_middle;
    spcorrspd.spcorrspd_weight = spcorrspd_weight;
    spcorrspd.latindex = left_average;
     save([para.SiftFlowPath ImageName(1:end-4) '.mat'],'spcorrspd');
     fprintf('frame %d done!\n', ImgIndex); 
end