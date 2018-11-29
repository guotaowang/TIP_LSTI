function [rpnaverage,leftaverage] = FastQualitAccess(para)
    index = 0; 
% 
    for batch_index = 1:para.BatchNum
            average_all = []; 
        for file_index = 1:para.BatchSize(1, batch_index)
            index = index + 1;
            ImageName = para.Files(index).name;
            average = load([ para.AveragePath ImageName(1:end-4) 'average.mat']);
            average_all = [average_all; average.average];
        end
        average_new = sortrows(average_all,2);
        leftaverage{batch_index} = average_new(end-2:end,1);
    end

        N = floor(para.LengthFiles*0.3);
        average_all = []; 
        for i=1:para.LengthFiles-1
             ImageName = para.Files(i).name;
              average = load([ para.AveragePath ImageName(1:end-4) 'average.mat']);
              average = average.average;
              average_all = [average_all; average];
        end
        average_new = sortrows(average_all,2);
        rpnaverage = average_new((end-N):end,1);
        rpnaverage
end