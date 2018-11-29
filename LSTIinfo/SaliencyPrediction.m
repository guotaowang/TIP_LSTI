function SaliencyPrediction(vote,scale,para,mode,SmoothMotionSaliency)%
        LengthFiles = para.LengthFiles-1;
        Files = para.Files;

        ring = SmoothMotionSaliency.ring ;    SP_all = SmoothMotionSaliency.SP_all ;  SPnum = SmoothMotionSaliency.SP_num ;    MaxDim = SmoothMotionSaliency.MaxDim;
        I = SmoothMotionSaliency.all_I  ; 
        net = init_net(); %load model     
        SaliencyM{2} = ones(MaxDim,LengthFiles)*0.01;  

     for ImgIndex=1:LengthFiles
            ImageName = Files(ImgIndex).name;       
            all_all_scalefeat=load([para.AllScaleFeatPath ImageName(1:end-4) '.mat']);
            all_scalefeat = all_all_scalefeat.all_all_scalefeat{1};
            SP_index = all_scalefeat(:,1);
            res = PredictHighVec(net,all_scalefeat(:,2:end));
            b_11=res(:,2); 
            SP2= all_all_scalefeat.all_all_scalefeat{3};
            SaliencyM{2}(SP_index(1: SP2),ImgIndex) =  b_11;
     end
     caffe.reset_all();      
     
        for scale_index=2:2
                    N=LengthFiles;
                     ring_new = ring{scale_index};  MaxDim_scale = MaxDim;  SPnum_new = SPnum;
                     LastBatchSaliencyRecord=zeros(MaxDim_scale,N);
                     SaliencyM{scale_index} = Final_smooth(ring_new,SaliencyM{scale_index},MaxDim_scale, N,60.0,SPnum_new,0.0,50.0);
                    for i=1:N
                        ImageName = Files(i).name;
                            Result = zeros(150,150); 
                            ResultBox = zeros(300,300);
                            SaliencyAssignTemp=(SaliencyM{scale_index}(:,i));
                            if i>1  
                                SaliencyAssignTemp0=(SaliencyM{scale_index}(:,i-1));
                            else
                                SaliencyAssignTemp0=(SaliencyM{scale_index}(:,i));
                            end
                            if i<N
                                SaliencyAssignTemp2=(SaliencyM{scale_index}(:,i+1));
                            else
                                SaliencyAssignTemp2=(SaliencyM{scale_index}(:,i));
                            end
                           LastBatchSaliencyRecord(:,i)=colorsm2(ring_new,i-1,MaxDim_scale,SaliencyAssignTemp,SaliencyAssignTemp0,SaliencyAssignTemp2,N,10.0,55.0,SPnum_new);%cuda and C program
                            for l=1:SP_all{scale_index}(i).SuperPixelNumber
                                    ClusteringPixelNumber = SP_all{scale_index}(i).ClusteringPixelNum(1,l);
                                    for j=1:ClusteringPixelNumber
                                            XIndex= SP_all{scale_index}(i).Clustering(l,j,1);
                                            YIndex= SP_all{scale_index}(i).Clustering(l,j,2);
                                            Result(XIndex,YIndex) = LastBatchSaliencyRecord(l,i);
                                    end
                            end
                            SP_Rect = SP_all{scale_index}(i).Rect;
                            H = SP_Rect(1,2)-SP_Rect(1,1)+1; W = SP_Rect(1,4)-SP_Rect(1,3)+1;
                            Result = imresize(Result,[H, W]);
                            
                            ResultBox(SP_Rect(1,1):SP_Rect(1,2),SP_Rect(1,3):SP_Rect(1,4)) = Result;
                           path_2 = [para.NosmoothPath ImageName];
                           imwrite(ResultBox, path_2);
                            clear ResultBox;
                    end
        end
        for i=1:LengthFiles
                ImageName = Files(i).name;
                temp = MatrixNormalization(double(imread([para.NosmoothPath ImageName])));
                
                temp2 = MatrixNormalization(imresize(double(imread(['.\sequence\' mode '\' ImageName])),[300,300]));
                tem=pixelAssign(temp,temp2,20,25);%cuda and C program
                tem = MatrixNormalization(tem);
                tem = imresize(tem,[para.W, para.H]);
                path_2 = [para.FinalImagePath ImageName];
                imwrite(tem, path_2);
        end
    end