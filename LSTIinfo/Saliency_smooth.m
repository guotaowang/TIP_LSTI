function Saliency_smooth(para,i,MotSaliencyM,ring,MaxDim,SPnum,SP_all,I,N,mode) 
        scale_index = 1;
         MotSaliencyM= MatrixNormalization(Final_smooth(ring,MotSaliencyM,MaxDim, N,10.0,SPnum,0.0,70.0));
        LastBatchSaliencyRecord=zeros(MaxDim,N);
            ImageName = para.Files(i).name;
            Result = zeros(300,300);
            SaliencyAssignTemp=(MotSaliencyM(:,i));
            if i>1
                SaliencyAssignTemp0=(MotSaliencyM(:,i-1));
            else
                SaliencyAssignTemp0=(MotSaliencyM(:,i));
            end
            if i<N
                SaliencyAssignTemp2=(MotSaliencyM(:,i+1));
            else
                SaliencyAssignTemp2=(MotSaliencyM(:,i));
            end

            LastBatchSaliencyRecord(:,i)=colorsm2(ring ,i-1,MaxDim ,SaliencyAssignTemp,SaliencyAssignTemp0,SaliencyAssignTemp2,N,20,10,SPnum);%cuda and C program
            for l=1:SP_all(i).SuperPixelNumber
                ClusteringPixelNumber = SP_all(i).ClusteringPixelNum(1,l);
                for j=1:ClusteringPixelNumber
                    XIndex= SP_all(i).Clustering(l,j,1);
                    YIndex= SP_all(i).Clustering(l,j,2);
                    Result(XIndex,YIndex) = LastBatchSaliencyRecord(l,i);
                end
            end
            Result = MatrixNormalization(Result);
            imwrite(Result, [para.SmoothedMotionSaliencyPath ImageName(1:end-4) '.jpg']);
end