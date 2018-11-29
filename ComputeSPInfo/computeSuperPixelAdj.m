%compute super pixel adj matrix

function [AdjMatrix] = computeSuperPixelAdj(SP,Ranges)

EuDistMatrix = zeros(SP.SuperPixelNumber,SP.SuperPixelNumber);
PosMatrix = SP.MiddlePoint(:,1:2);
for i=1:SP.SuperPixelNumber
    EuDistMatrix(i,:) = (sum(abs(bsxfun(@minus,PosMatrix',PosMatrix(i,:)'))));
end

%Filter
temp = bsxfun(@minus,EuDistMatrix,Ranges(:,1));
[index] = find(temp(:)<0);%ranges based filter
temp = EuDistMatrix(:);
temp(index) = 0;
EuDistMatrix = reshape(temp,[SP.SuperPixelNumber,SP.SuperPixelNumber]);

temp = bsxfun(@minus,EuDistMatrix,Ranges(:,2));
[index] = find(temp(:)>0);
temp = EuDistMatrix(:);
temp(index) = 0;
EuDistMatrix = reshape(temp,[SP.SuperPixelNumber,SP.SuperPixelNumber]);

AdjMatrix = EuDistMatrix;
