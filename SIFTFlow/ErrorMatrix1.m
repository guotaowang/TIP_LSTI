function [errorMatrix,XX,YY]=ErrorMatrix1(sift1,sift2,vx,vy)
vx = imresize(vx,[50,50]);
vy = imresize(vy,[50,50]);

errorMatrix=double(zeros(50,50));

[xx,yy]=meshgrid(1:50,1:50);
[XX,YY]=meshgrid(1:50,1:50);

XX=XX+vx;
YY=YY+vy;

mask=XX<1 | XX>50 | YY<1 | YY>50;
XX=min(max(XX,1),50);
YY=min(max(YY,1),50);

for i=1:50*50 
    errorMatrix(xx(i),yy(i))=sqrt( sum( abs( sift1(xx(i),yy(i),:)-sift2(XX(i),YY(i),:) ).^2) );
end

% errorMatrix(mask)=0;
errorMatrix = normalizeMatrix(errorMatrix);
end