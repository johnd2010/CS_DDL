function [image] = imagerecreator(vector,NoofPatches,s)
%IMAGERECREATOR Recreate the image from the vector 
%   output -> Image
%   vector -> reconstructed vector
%   NoofPatches -> No of patches to be created from the vector
%   s -> size limit on rows
row=[];
image=[];
for i=1:size(vector,2)
    v1=reshape(vector(:,i),[NoofPatches NoofPatches]);
    row=[row;v1];
    if s(1)==size(row,1)
        image=[image row];
        row=[];
    end
end
end

