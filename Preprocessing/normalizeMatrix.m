function [I] = normalizeMatrix(I)

maxValue = max(max(I));
minValue = min(min(I));

if(maxValue-minValue~=0)
I = (I-minValue)/(maxValue-minValue);
end