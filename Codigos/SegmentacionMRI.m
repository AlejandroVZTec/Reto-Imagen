%%%SEGMENTACION MRI

clear all; close all; clc;
%% Cargando imagenes

%imagen 1
f1=imread('CT_CHEST.jpeg');
f1=double(f1(:,:,1));
f1=f1/max(max(f1));
f1=imresize(f1,0.85);
figure(1)
imshow(f1,[]);

%imagen 2
f2=imread('CT-abdomenal.jpg');
f2=double(f2(:,:,1));
f2=f2/max(max(f2));
f2=imresize(f2,0.85);
figure(1)
imshow(f2,[]);

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