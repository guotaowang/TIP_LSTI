imgDataPath_1 = 'E:\results_nosiftnew\';imgDataPath_2 = 'F:\original\';
imgDataDir  = dir(imgDataPath_1);             % 遍历所有文件
for i = 3:length(imgDataDir)
% for i = 3:
     imgDir = dir([imgDataPath_2 imgDataDir(i).name '\*.jpg']); 
     mkdir([imgDataPath_1 imgDataDir(i).name '\5\' ]);
     imgDataDir(i).name
    for j =1:length(imgDir)-1               % 遍历所有图片
        img = MatrixNormalization(double(imread([imgDataPath_1 imgDataDir(i).name '\3\2smoothed_2' imgDir(j).name])));
        img_1 = MatrixNormalization(imresize(double(imread([imgDataPath_2 imgDataDir(i).name '\' imgDir(j).name])),[300,300]));
        tem=pixelAssign(img,img_1,20,25);
        imwrite(tem,[imgDataPath_1 imgDataDir(i).name '\5\'  imgDir(j).name]);
    end
end
