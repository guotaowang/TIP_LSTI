function showSLIC(img,labels)
[row col] = size(labels);
result = zeros(row,col,3);
result = img;
for i=2:row-1
    for j=2:col-1
        flag = 0;
        if(labels(i-1,j-1)~=labels(i,j))
            flag = 1;
        end
                if(labels(i-1,j)~=labels(i,j))
            flag = 1;
                end
                if(labels(i-1,j+1)~=labels(i,j))
            flag = 1;
                end
                if(labels(i,j-1)~=labels(i,j))
            flag = 1;
                end
                if(labels(i,j+1)~=labels(i,j))
            flag = 1;
                end
                if(labels(i+1,j-1)~=labels(i,j))
            flag = 1;
                end
                        if(labels(i+1,j-1)~=labels(i,j))
            flag = 1;
                        end
                        if(labels(i+1,j-1)~=labels(i,j))
            flag = 1;
                        end
        if(flag==1)
            result(i,j,:) = [255,0,0]';
        end
    end
end
imshow(result)
end