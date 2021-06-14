function [ Patch,vecpatch ] = patchcreator(image,n)
%COMPRESSIVESENSING Creates square patches of size n and vector of size nxn
%   input image -> image of size pxq n -> size of square patch 
%   output Patch -> matrix with nx(pxq/n) Vecpatch -> (nxn)x(pxq/(nxn))
Patch=[];
vecpatch=[];
for i=1:n:size(image,2)
    for j=1:n:size(image,1)
        smimage=imcrop(image,[i,j,n-1,n-1]);
        Patch=[Patch smimage];
        vecpatch=[vecpatch smimage(:)];
    end
end
end