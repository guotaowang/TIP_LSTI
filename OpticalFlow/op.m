fileFolder=fullfile('E:\LSTI_AAAI2018\results\bear\OpticalFlowResults');

dirOutput=dir(fullfile(fileFolder,'*.mat'));
fileNames={dirOutput.name}';
for i =1:size(fileNames,1)
   op_xy  = load([fileFolder '\' fileNames{i}]);
   flow(:,:,1) = op_xy.vx;
    flow(:,:,2) = op_xy.vy;
    imflow = flowToColor(flow);
    figure,imshow(imflow);
    path = [fileFolder '\' fileNames{i}(1:end-4) '.jpg'];
    imwrite(imflow,path,'quality',100);
end


