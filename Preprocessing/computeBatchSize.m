function BatchSize = computeBatchSize(LengthFiles,BatchInitSpan)

%BatchInitSpan = 9;
BatchNum = floor((LengthFiles)/(BatchInitSpan-1));
BatchResidual = mod(LengthFiles,BatchInitSpan-1);
for i=1:BatchNum
   BatchSize{i} = BatchInitSpan-1;
end
index = 1;
while(1)
    if(BatchResidual==0)
        break;
    end
    BatchSize{index} = BatchSize{index} + 1;
    BatchResidual = BatchResidual-1;
    index = index + 1;
    if(index>BatchNum)
        index = 1;
    end
end