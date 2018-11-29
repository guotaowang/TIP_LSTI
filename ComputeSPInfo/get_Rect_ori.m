function boxes = get_Rect_ori(LOW)
% boxes_all = [];
    LOW_1=im2bw(LOW, graythresh(LOW)*0.2);
    LOW_1 = imdilate(LOW_1, strel('square',60));
    [r, c]=find(LOW_1==1) ; 
    r_min = min(r); r_max = max(r); c_min = min(c); c_max= max(c); 
    % height = r_max-r_min; width = c_max - c_min;
    boxes = [r_min, r_max , c_min, c_max];

