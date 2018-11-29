function DeepFeatureComputation(vote,scale,ImgIndex,para,mode)
    Files = para.Files;
    ImageName = Files(ImgIndex).name;
    spcorrspd = load([para.SiftFlowPath ImageName(1:end-4) '.mat']);
    spcorrspd = spcorrspd.spcorrspd ;  latindex = spcorrspd.latindex;
    spcorrspd_weight = spcorrspd.spcorrspd_weight;  cur_middle = spcorrspd.cur_middle;  spcorrspd_index = spcorrspd.spcorrspd_index;
    all_scalefeat = [];
    
    CurPatchFeas = load([para.ImageRectPath ImageName(1:end-4) '_feas.mat']);
    latImaName_1 = Files(latindex(1,1)).name; latImaName_2 = Files(latindex(1,2)).name;
    LatPatchFeas_1 = load([para.ImageRectPath latImaName_1(1:end-4) '_feas.mat']);
    LatPatchFeas_2 = load([para.ImageRectPath latImaName_2(1:end-4) '_feas.mat']);
    for scale_index = 2: 2
        PCurPatchFeas = CurPatchFeas.allbatchfeas{scale_index};
        [min_score, index] = min(spcorrspd_weight{scale_index},[],2); nwb = [min_score, index]; xmm = find(nwb(:,1)>(max(min_score)-0.2));
        index_1 = find(index == 1);index_2 = find(index == 2);
        index_1_1 = spcorrspd_index{scale_index}(index_1,1);index_2_2 = spcorrspd_index{scale_index}(index_2,2);
        PLatPatchFeas(index_1,:) = LatPatchFeas_1.allbatchfeas{scale_index}(index_1_1,2:end);
        PLatPatchFeas(index_2,:) = LatPatchFeas_2.allbatchfeas{scale_index}(index_2_2,2:end);
        PLatPatchFeas(xmm,:) =PCurPatchFeas(xmm,2:end);
        all_scalefeat = [all_scalefeat; PCurPatchFeas, PLatPatchFeas];
    end
    all_all_scalefeat{1} = all_scalefeat; 
    all_all_scalefeat{2} = CurPatchFeas.allbatchfeas{3}; all_all_scalefeat{3} = CurPatchFeas.allbatchfeas{4};
    save([para.AllScaleFeatPath ImageName(1:end-4) '.mat'], 'all_all_scalefeat');
    fprintf('frame %d done!\n', ImgIndex) 
end