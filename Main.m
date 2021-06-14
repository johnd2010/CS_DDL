clc;
clear;
close all;
load lena.mat;
% imread('cameraman.tif');
% rgb2gray(imread('baboon.png'));
% rgb2gray(imread('tulips.png'));
% rgb2gray(imread('airplane.png'));
% (imread('sails.bmp'));
image=ans;
maxiterdict=100;
maxiterista=50;
NoOfDictionaries=3
lambda=3;
mu=0.04;
% Xorg=im2double(imresize(ans,0.125));
si=128;
s=0;
psnr1=[];
count=0;
while si<=min(size(image))
    s=s+1;
    crop=image(1:si,1:si);
    Xorg=im2double(crop);
    allowable=64;
    gb=1;
    n=size(Xorg,1);
    m=90;% % of size of sensing matrix
    NoofPatchesinternal=4;
    X1=Xorg+normc(normrnd(0,1,size(Xorg,1),size(Xorg,2))); % adding noise
    count=count+1;
    figure(count);
    count=count+1;
    imshow(Xorg)  ;
    count=count+1;
    figure(count);
    count=count+1;
    imshow(X1);
    psnrbeforedenoising=calPSNR(Xorg,X1)
    NoofPatches=ceil(length(Xorg(:))/(allowable*allowable));% patches from image
    [Px,vecpatch]=patchcreator(Xorg,NoofPatches);
    maxp=0;
    for NoOfDictionaries=1:5
        NoOfDictionaries
        rec1=[maxiterdict maxiterista lambda mu];
        reccolumn=[];
        parfor j=1:ceil(size(Px,2)/allowable)
            i=(j-1)*allowable+1;
            [rec]=Method1(Px(:,i:i+allowable-1),gb,allowable,NoofPatchesinternal,m,lambda,mu,maxiterdict,maxiterista,NoOfDictionaries);
            reccolumn=[reccolumn; rec];
        end
        rec=reccolumn;
        recimg=[];
        for i=1:size(Xorg,1):size(reccolumn,1)
            recimg=[recimg rec(i:i+size(Xorg,1)-1,:)];
        end
        psnrafterdenoising=calPSNR(Xorg,recimg)
        psnr1(s,NoOfDictionaries)=psnrafterdenoising;
        count=count+1;
        figure(count)
        count=count+1;
        imshow(recimg)
    end
    si=si*2
end


% % plot(1:NoOfDictionaries,psnr1)
% % hold on;
% xlabel('No Of Dictionaries');
% ylabel('PSNR');
%  legend('128x128','256x256','512x512');
% title('PSNR vs No Of Dictionaries for Lenna');