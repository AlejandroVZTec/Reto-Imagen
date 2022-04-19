%%%SEGMENTACION MRI

clear all; close all; clc;
%% 

f=imread('CT_CHEST.jpg');
f=double(f(:,:,1));
f=f/max(max(f));
f=imresize(f,0.85);
figure(1)
imshow(f,[]);
%% Thresholding

seg1 = f > 0.5;
imshow(seg1,[])
imshow(seg1.*f,[])
seg1 = f < 0.75;
imshow(seg1,[])
imshow(seg1.*f,[])

imhist(f)
% Use a third threshold based on the histogram
%% 
%% Otsu method

thr = graythresh(f)
seg1 = f > thr;
imshow(seg1,[])
dxp=[0,1;-1,0];
dyp=[1,0;0,-1];
edgemap = abs(conv2(seg1,dxp,'same'))+abs(conv2(seg1,dyp,'same'));
imshow(f+edgemap,[0,1]);
% Compare the otsu provided threshold vs the one you selected in the
% preview step.
% Do you trust the Otsu treshold?
% Select your own image and compute the otsu