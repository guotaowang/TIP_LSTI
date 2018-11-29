function SuperPixelMatchingFunction(vote,scale,CImgIndex,para)
        RandPicOutputOriginalPath = para.RandPicOutputOriginalPath;
        Files = para.Files;
        ImageName = Files(CImgIndex).name;

        cur_Pic=load([RandPicOutputOriginalPath ImageName(1:end-4) '_RandPick.mat']);
%% current frame
  for scale_index=1:scale
        SP1=cur_Pic.Frame.Frame_SP{1}.segmentationData{scale_index};
%% latFrame
     for index = 2:vote
        SP2=cur_Pic.Frame.Frame_SP{index}.segmentationData{scale_index};  
        XXYY_1= cur_Pic.Cursift{index};
        XX_1=XXYY_1.XX;
        YY_1=XXYY_1.YY;
        spcorrspd{scale_index}{index}=zeros(SP1.SuperPixelNumber,2);
        for i_1=1:SP1.SuperPixelNumber
                im3=zeros(1,SP1.ClusteringPixelNum(1,i_1));
                for j_1=1:SP1.ClusteringPixelNum(1,i_1)
                     im3(1,j_1)=SP2.SEGMENTS(YY_1(SP1.Clustering(i_1,j_1,1),SP1.Clustering(i_1,j_1,2)),XX_1(SP1.Clustering(i_1,j_1,1),SP1.Clustering(i_1,j_1,2)));
                end
                tabu1=tabulate(im3(:));
                tabu1=sortrows(tabu1,2);
                tabus1=size(tabu1,1);
                spcorrspd{scale_index}{index}(i_1,1)=tabu1(tabus1,1);
                spcorrspd{scale_index}{index}(i_1,2)=tabu1(tabus1,2)/SP1.ClusteringPixelNum(1,i_1);
        end
     end
  end
           save([ RandPicOutputOriginalPath ImageName(1:end-4) '_RandPick.mat'],'spcorrspd','-append');
end

