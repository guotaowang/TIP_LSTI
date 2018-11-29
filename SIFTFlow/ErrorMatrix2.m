function [errorMatrix,XX,YY]=ErrorMatrix2(sift1,sift2,vx,vy)
vx = imresize(vx,[150,150]);
vy = imresize(vy,[150,150]);

errorMatrix=double(zeros(150,150));

[xx,yy]=meshgrid(1:150,1:150);
[XX,YY]=meshgrid(1:150,1:150);

XX=XX+vx;
YY=YY+vy;

mask=XX<1 | XX>150 | YY<1 | YY>150;
XX=min(max(XX,1),150);
YY=min(max(YY,1),150);

for i=1:150*150 
    errorMatrix(xx(i),yy(i))=sqrt( sum( abs( sift1(xx(i),yy(i),:)-sift2(XX(i),YY(i),:) ).^2) );
end

% errorMatrix(mask)=0;
errorMatrix = normalizeMatrix(errorMatrix);
end